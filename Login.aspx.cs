using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;

namespace OneStopStudentSystem
{
    public partial class Login : System.Web.UI.Page
    {
        private const int MaxFailedLoginAttempts = 3;
        private const int LockoutDurationHours = 24;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["logout"] == "true")
            {
                FormsAuthentication.SignOut();
                Context.GetOwinContext().Authentication.SignOut();
                Session.Clear();
                Session.Abandon();
                Response.Redirect("~/Login.aspx");
            }
        }


        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string usernameOrEmail = txtUsernameOrEmail.Text;
            string password = txtPsw.Text;

            var (userType, username, userId) = ValidateUser(usernameOrEmail, password);
            var (isAccLock, lockTime) = LockAccount(usernameOrEmail);

            if (isAccLock == true)
            {
                if (lockTime.HasValue && lockTime.Value.AddHours(LockoutDurationHours) > DateTime.Now)
                {
                    lblErrorMsg.Text = "Your account has been locked due to 3 invalid login attempt. Please try again after 24 hours or wait for admin to unlock account.";
                    lblErrorMsg.Visible = true;
                    return;
                }
                else
                {
                    UnlockAccount(usernameOrEmail);
                    if (!string.IsNullOrEmpty(userType))
                    {
                        Session["UserType"] = userType;
                        Session["Username"] = username;
                        Session["UserID"] = userId;

                        if (userType == "Admin")
                        {
                            Response.Redirect("AdminRoleMng.aspx");
                        }
                        else if (userType == "Student" || userType == "TempUser")
                        {
                            Response.Redirect("Homepage.aspx");
                        }

                    }
                    else
                    {
                        lblErrorMsg.Text = "Invalid username/email or password.";
                        IncrementFailedLoginAttempts(usernameOrEmail);
                    }
                }
            }
            else
            {
         
                if (!string.IsNullOrEmpty(userType))
                {
                    Session["UserType"] = userType;
                    Session["Username"] = username;
                    Session["UserID"] = userId;
                    UnlockAccount(usernameOrEmail);
                    if (userType == "Admin")
                    {
                        Response.Redirect("AdminRoleMng.aspx");
                    }
                    else if (userType == "Student" || userType == "TempUser")
                    {
                        Response.Redirect("Homepage.aspx");
                    }

                }
                else
                {
                    lblErrorMsg.Text = "Invalid username/email or password.";
                    IncrementFailedLoginAttempts(usernameOrEmail);
                }
            }
        }


        private void UnlockAccount(string usernameOrEmail)
        {
            string query = @"
                UPDATE Student 
                SET IsAccountLocked = 0, AccountLockTime = NULL, FailedLoginAttempts = 0
                WHERE studentUsername = @Username OR studentEmail = @Email";
            string query1 = @"
                UPDATE TempUser 
                SET IsAccountLocked = 0, AccountLockTime = NULL, FailedLoginAttempts = 0
                WHERE tempUserUsername = @Username OR tempUserEmail = @Email";

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", usernameOrEmail);
                    command.Parameters.AddWithValue("@Email", usernameOrEmail);
                    command.ExecuteNonQuery();
                }
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query1, connection))
                {
                    command.Parameters.AddWithValue("@Username", usernameOrEmail);
                    command.Parameters.AddWithValue("@Email", usernameOrEmail);
                    command.ExecuteNonQuery();
                }
            }
        }

        private (bool isLocked, DateTime? lockTime) LockAccount(string usernameOrEmail)
        {
            string query = "SELECT IsAccountLocked, AccountLockTime FROM Student WHERE studentUsername = @Username OR studentEmail = @Email";
            string query1 = "SELECT IsAccountLocked, AccountLockTime FROM TempUser WHERE tempUserUsername = @Username OR tempUserEmail = @Email";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", usernameOrEmail);
                    command.Parameters.AddWithValue("@Email", usernameOrEmail);
                    command.ExecuteNonQuery();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return ((bool)reader["IsAccountLocked"], reader["AccountLockTime"] == DBNull.Value ? (DateTime?)null : (DateTime)reader["AccountLockTime"]);
                        }

                    }
                }
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();
                using (SqlCommand command = new SqlCommand(query1, connection))
                {
                    command.Parameters.AddWithValue("@Username", usernameOrEmail);
                    command.Parameters.AddWithValue("@Email", usernameOrEmail);
                    command.ExecuteNonQuery();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return ((bool)reader["IsAccountLocked"], reader["AccountLockTime"] == DBNull.Value ? (DateTime?)null : (DateTime)reader["AccountLockTime"]);
                        }

                    }
                }
            }
            return (false, null);
        }

        private void IncrementFailedLoginAttempts(string usernameOrEmail)
        {
            string studentQuery = @"
                    UPDATE Student 
                    SET FailedLoginAttempts = FailedLoginAttempts + 1, 
                        IsAccountLocked = CASE WHEN FailedLoginAttempts + 1 >= @MaxAttempts THEN 1 ELSE IsAccountLocked END,
                        AccountLockTime = CASE WHEN FailedLoginAttempts + 1 >= @MaxAttempts THEN GETDATE() ELSE AccountLockTime END
                    WHERE studentUsername = @Username OR studentEmail = @Email";

            string tempUserQuery = @"
                    UPDATE TempUser 
                    SET FailedLoginAttempts = FailedLoginAttempts + 1, 
                        IsAccountLocked = CASE WHEN FailedLoginAttempts + 1 >= @MaxAttempts THEN 1 ELSE IsAccountLocked END,
                        AccountLockTime = CASE WHEN FailedLoginAttempts + 1 >= @MaxAttempts THEN GETDATE() ELSE AccountLockTime END
                    WHERE tempUserUsername = @Username OR tempUserEmail = @Email";

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(studentQuery, connection))
                    {
                        command.Parameters.AddWithValue("@Username", usernameOrEmail);
                        command.Parameters.AddWithValue("@Email", usernameOrEmail);
                        command.Parameters.AddWithValue("@MaxAttempts", MaxFailedLoginAttempts);
                        // command.Parameters.AddWithValue("@CurrentTime", DateTime.Now);
                        command.ExecuteNonQuery();
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Failed to increment login attempts for Student: " + ex.Message);
                    throw;
                }

                try
                {
                    using (SqlCommand command = new SqlCommand(tempUserQuery, connection))
                    {
                        command.Parameters.AddWithValue("@Username", usernameOrEmail);
                        command.Parameters.AddWithValue("@Email", usernameOrEmail);
                        command.Parameters.AddWithValue("@MaxAttempts", MaxFailedLoginAttempts);
                        //   command.Parameters.AddWithValue("@CurrentTime", DateTime.Now);
                        command.ExecuteNonQuery();
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Failed to increment login attempts for TempUser: " + ex.Message);
                    throw;
                }
            }
        }

        protected void BtnGoogleLogin_Click(object sender, EventArgs e)
        {

            // var properties = new AuthenticationProperties { RedirectUri = "/GLCallback" };
            var properties = new AuthenticationProperties { RedirectUri = "https://localhost:44355/GLCallback.aspx" };
            Context.GetOwinContext().Authentication.Challenge(properties, "Google");

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void linkForgotPsw_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void txtPhone_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtPsw_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {

        }

        private (string userType, string username, string userId) ValidateUser(string usernameOrEmail, string password)
        {
            string adminQuery = "SELECT adminId, adminUsername FROM Admin WHERE (adminUsername = @Username OR adminEmail = @Email) AND adminPassword = @Password";
            string studentQuery = "SELECT studentID, studentUsername FROM Student WHERE (studentUsername = @Username OR studentEmail = @Email) AND studentPassword = @Password";
            string tempUserQuery = "SELECT tempUserID, tempUserUsername FROM tempUser WHERE (tempUserUsername = @Username OR tempUserEmail = @Email) AND tempUserPassword = @Password";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check Admin table
                using (SqlCommand command = new SqlCommand(adminQuery, connection))
                {
                    command.Parameters.AddWithValue("@Username", usernameOrEmail);
                    command.Parameters.AddWithValue("@Email", usernameOrEmail);
                    command.Parameters.AddWithValue("@Password", password);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return ("Admin", reader["adminUsername"].ToString(), reader["adminId"].ToString());
                        }
                    }
                }

                // Check Student table
                using (SqlCommand command = new SqlCommand(studentQuery, connection))
                {
                    command.Parameters.AddWithValue("@Username", usernameOrEmail);
                    command.Parameters.AddWithValue("@Email", usernameOrEmail);
                    command.Parameters.AddWithValue("@Password", password);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return ("Student", reader["studentUsername"].ToString(), reader["studentID"].ToString());
                        }
                    }
                }

                // Check TempUser table
                using (SqlCommand command = new SqlCommand(tempUserQuery, connection))
                {
                    command.Parameters.AddWithValue("@Username", usernameOrEmail);
                    command.Parameters.AddWithValue("@Email", usernameOrEmail);
                    command.Parameters.AddWithValue("@Password", password);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return ("TempUser", reader["tempUserUsername"].ToString(), reader["tempUserID"].ToString());
                        }
                    }
                }
            }

            return (null, null, null);
        }



        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            txtUsernameOrEmail.Text = string.Empty;
            txtPsw.Text = string.Empty;
            lblErrorMsg.Text = string.Empty;
        }
    }
}