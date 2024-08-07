using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.Owin.Security;
using Microsoft.AspNet.Identity;
using System.Security.Claims;
using System.Diagnostics;
using System.Configuration;
using System.Data.SqlClient;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Util.Store;
using Google.Apis.Calendar.v3;
using System.Threading;

namespace OneStopStudentSystem
{
    public partial class Callback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var authenticationManager = Context.GetOwinContext().Authentication;
                var loginInfo = authenticationManager.GetExternalLoginInfo();

                if (loginInfo != null)
                {
                    var claimsIdentity = new ClaimsIdentity(loginInfo.ExternalIdentity.Claims, DefaultAuthenticationTypes.ApplicationCookie);
                    authenticationManager.SignIn(new AuthenticationProperties { IsPersistent = true }, claimsIdentity);

                    var emailClaim = claimsIdentity.FindFirst(ClaimTypes.Email);
                    if (emailClaim != null)
                    {
                        Session["Username"] = emailClaim.Value;
                        Session["UserType"] = "Student";
                        var email = Session["Username"].ToString();
                        var studentId = GenerateNextStudentID();
                        var username = email;

                        if (!UserExists(email))
                        {
                            InsertStudent(studentId, username, email);
                            string userID = GetNextUserId();
                            Session["UserID"] = studentId;
                            SaveIntoUser(userID, studentId, "Student");
                        }
                        else
                        {
                            string studentId1 = GetStudentIDFromDatabase(email);
                            Session["UserID"] = studentId1; 
                        }


                        string redirectUri = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/GLCallback.aspx";
                        Debug.WriteLine($"Redirect URI: {redirectUri}");

                        RequestCalendarPermissions();

                        Response.Redirect("~/Homepage.aspx", false);
                    }
                    else
                    {
                        Response.Redirect("~/Login.aspx", false);
                    }
                }
                else
                {
                    Response.Redirect("~/Login.aspx", false); 
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Exception in GoogleLoginCallback Page_Load: {ex.Message}");
                Response.Redirect("~/Error.aspx", false); 
            }
        }

        private void RequestCalendarPermissions()
        {
            try
            {
                string[] scopes = { CalendarService.Scope.Calendar };
                var clientSecrets = new ClientSecrets
                {
                    ClientId = "784717365865-enram9uscljmvl555t4ikkqn1f11lsc4.apps.googleusercontent.com",
                    ClientSecret = "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",
                };

                string redirectUri = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/Callback.aspx"; 
                Debug.WriteLine($"Redirect URI: {redirectUri}");

                var credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                    clientSecrets,
                    scopes,
                    "user",
                    CancellationToken.None,
                    new FileDataStore("Calendar.Auth.Store")).Result;

                // Store the tokens securely in the database
                StoreTokens(credential.Token.AccessToken, credential.Token.RefreshToken);

                Response.Redirect("~/Homepage.aspx", false);
            }
            catch (AggregateException ex)
            {
                foreach (var e in ex.InnerExceptions)
                {
                    Debug.WriteLine($"Exception in RequestCalendarPermissions: {e.Message}");
                }
                Response.Redirect("~/Error.aspx", false);
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Exception in RequestCalendarPermissions: {ex.Message}");
                Response.Redirect("~/Error.aspx", false);
            }
        }



        private void StoreTokens(string accessToken, string refreshToken)
        {
            try
            {
                string userId = Session["UserID"].ToString();
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string query = "UPDATE Student SET AccessToken = @AccessToken, RefreshToken = @RefreshToken WHERE studentID = @StudentID";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@AccessToken", accessToken);
                        command.Parameters.AddWithValue("@RefreshToken", refreshToken);
                        command.Parameters.AddWithValue("@StudentID", userId);
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Exception in StoreTokens: {ex.Message}");
            }
        }

        private string GetStudentIDFromDatabase(string email)
        {
            string userID = string.Empty;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT studentID FROM Student WHERE studentEmail = @Email";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    var result = command.ExecuteScalar();
                    if (result != null)
                    {
                        userID = result.ToString();
                    }
                }
            }

            return userID;
        }

        private string GetNextUserId()
        {
            string nextUserId = "U0001";

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT MAX(userID) FROM UserAccount";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        string maxUserId = result.ToString();
                        int number;
                        if (int.TryParse(maxUserId.Substring(1), out number))
                        {
                            nextUserId = "U" + (number + 1).ToString().PadLeft(4, '0');
                        }
                    }
                }
            }

            return nextUserId;
        }

        private bool UserExists(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM Student WHERE studentEmail = @Email";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        protected void SaveIntoUser(string userID, string studentID, string role)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO UserAccount (userID, userRole, adminId, studentId, tempUserID) VALUES (@UserID, @UserRole, @adminId, @studentId, @tempUserID)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserID", userID);
                    command.Parameters.AddWithValue("@UserRole", role);
                    command.Parameters.AddWithValue("@adminId", DBNull.Value);
                    command.Parameters.AddWithValue("@studentId", studentID);
                    command.Parameters.AddWithValue("@tempUserID", DBNull.Value);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
        private void InsertStudent(string studentId, string username, string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "INSERT INTO Student (studentID, studentUsername, studentEmail, FailedLoginAttempts, IsAccountLocked) VALUES (@StudentID, @Username, @Email, @LA, @locked)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentID", studentId);
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@LA", 0);
                    command.Parameters.AddWithValue("@locked", 0);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
        private string GenerateNextStudentID()
        {
            string nextStudentId = "S0001";

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT MAX(studentID) FROM Student";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        string maxStudentID = result.ToString();
                        int number;
                        if (int.TryParse(maxStudentID.Substring(1), out number))
                        {
                            nextStudentId = "S" + (number + 1).ToString().PadLeft(4, '0');
                        }
                    }
                }
            }

            return nextStudentId;
        }
    }

}
