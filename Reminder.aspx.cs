using Google.Apis.Auth.OAuth2;
using Google.Apis.Calendar.v3.Data;
using Google.Apis.Calendar.v3;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Threading;
using System.Web.UI.WebControls;
using System;
using Google.Apis.Auth.OAuth2.Flows;
using Google.Apis.Auth.OAuth2.Web;
using System.Web;
using System.Web.Security;
using System.Web.UI;
//using System.Net;
//using MailKit.Net.Smtp;
using MimeKit;
using System.Net.Mail;
using System.Net;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;


namespace OneStopStudentSystem
{
    public partial class Reminder : System.Web.UI.Page
    {
        private string[] Scopes = { CalendarService.Scope.Calendar };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                string alertMessage = "Please login first.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}'); window.location.href='Login.aspx';", true);
                return;
            }
            else if ((string)Session["UserType"] != "Student")
            {
                string alertMessage = "Please login as a Student.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}'); window.location.href='Login.aspx';", true);
                return;
            }
            CheckReminder(noReminderMsg);
            if (!IsPostBack)
            {
                GridView7.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (DateTime.TryParseExact(txtDateTime.Text, new[] { "yyyy-MM-dd hh:mm:ss tt", "yyyy-MM-dd HH:mm:ss" }, CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime selectedDateTime))
            {
                if (AddReminderToDatabase(txtDateTime.Text, txtDesc.Text, txtName.Text))
                {
                    string studentID = Session["UserID"].ToString();
                    string studentEmail = GetStudentEmail(studentID);

                    // Send reminder email
                    SendReminderEmail(studentEmail, txtName.Text, txtDateTime.Text, txtDesc.Text);

                    // Add reminder to Google Calendar
                    AddEventToGoogleCalendar(studentEmail, studentID, txtName.Text, txtDateTime.Text, txtDesc.Text);
                   // AddEventToGoogleCalendar(txtName.Text, txtDesc.Text, txtDateTime.Text);
                    //  CalendarService calendarService = GetCalendarService("GC.json", studentEmail);
                    // CreateEvent(calendarService, studentEmail, txtName.Text, txtDateTime.Text, txtDesc.Text);


                    GridView7.DataBind();
                    txtDateTime.Text = string.Empty;
                    txtDesc.Text = string.Empty;
                    txtName.Text = string.Empty;
                    CheckReminder(noReminderMsg);
                }
            }
            else
            {
                string alertMessage = "Please enter a valid date and time in the format yyyy-MM-dd hh:mm:ss AM/PM (01:00:00 PM) or yyyy-MM-dd HH:mm:ss (13:00:00).";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}');", true);
            }
        }
        /*
        private void AddEventToGoogleCalendar(string eventName, string eventDesc, string eventDateTime)
        {
            // Path to the credentials file (client_secret.json downloaded from Google Cloud Console)
            string credPath = Server.MapPath("~/credentials.json");

            try
            {
                UserCredential credential;

                using (var stream = new FileStream(credPath, FileMode.Open, FileAccess.Read))
                {
                    // Load client secrets
                    credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                        GoogleClientSecrets.Load(stream).Secrets,
                        Scopes,
                        "user",
                        CancellationToken.None,
                        new FileDataStore("Calendar.API.Store")).Result;

                    // Once authorized, you can proceed with your logic
                    if (credential != null && credential.Token != null)
                    {
                        try
                        {
                            // Create the Calendar service
                            var service = new CalendarService(new BaseClientService.Initializer()
                            {
                                HttpClientInitializer = credential,
                                ApplicationName = "Calendar",
                            });

                            // Now you can use 'service' to interact with the Calendar API
                            // Example: Creating an event
                            var newEvent = new Event()
                            {
                                Summary = eventName,
                                Description = eventDesc,
                                Start = new EventDateTime() { DateTime = DateTime.Parse(eventDateTime), TimeZone = "Asia/Kuala_Lumpur" },
                                End = new EventDateTime() { DateTime = DateTime.Parse(eventDateTime).AddHours(1), TimeZone = "Asia/Kuala_Lumpur" }
                            };

                            // Define calendar id
                            string calendarId = "primary"; // You can specify your own calendar ID if needed

                            // Insert the event
                            EventsResource.InsertRequest request = service.Events.Insert(newEvent, calendarId);
                            Event createdEvent = request.Execute();

                            Console.WriteLine("Event created: {0}", createdEvent.HtmlLink);
                        }
                        catch (Exception ex)
                        {
                            // Handle exceptions
                            Response.Redirect("~/Error.aspx");
                        }
                    }
                    else
                    {
                        // Handle authorization failure
                        Response.Redirect("~/Error.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Response.Redirect("~/Error.aspx");
            }

        }
        */

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtDateTime.Text = string.Empty;
            txtDesc.Text = string.Empty;
            txtName.Text = string.Empty;
        }

        private void CheckReminder(Label label)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Reminder WHERE studentID = @studentID", conn);
                    cmd.Parameters.AddWithValue("@studentID", studentID);

                    int reminderCount = (int)cmd.ExecuteScalar();
                    label.Visible = (reminderCount == 0);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while checking tasks: " + ex.Message);
            }
        }

        private bool AddReminderToDatabase(string dateTime, string desc, string name)
        {
            if (string.IsNullOrWhiteSpace(dateTime) || string.IsNullOrWhiteSpace(name))
            {
                string alertMessage = "Please write something.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}');", true);
                return false;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();
            string newReminderID = GenerateNextID();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Reminder (ReminderID, eventName, eventDesc, studentID, dateTime) VALUES (@ID, @name, @desc, @studentID, @dateTime)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ID", newReminderID);
                        command.Parameters.AddWithValue("@name", name);
                        command.Parameters.AddWithValue("@desc", desc);
                        command.Parameters.AddWithValue("@studentID", studentID);
                        command.Parameters.AddWithValue("@dateTime", dateTime);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Failed to add reminder: {ex.Message}');", true);
                return false;
            }
        }

        private string GetStudentEmail(string studentID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentEmail = "";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT studentEmail FROM Student WHERE studentID = @studentID", conn);
                    cmd.Parameters.AddWithValue("@studentID", studentID);

                    studentEmail = cmd.ExecuteScalar()?.ToString();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while fetching student email: " + ex.Message);
            }

            return studentEmail;
        }


        protected void SendReminderEmail(string toEmail, string eventName, string dateTime, string eventDesc)
        {
            try
            {
                // Create the mail message
                MailMessage msg = new MailMessage();
                msg.To.Add(toEmail);
                msg.From = new MailAddress("lgk7878@gmail.com");
                msg.Subject = $"Reminder: {eventName}";
                msg.Body = $"Dear Student,\n\nYou have a reminder for '{eventName}' scheduled on {dateTime}.\n\nEvent Description: {eventDesc}";

                // Configure the SMTP client
                SmtpClient client = new SmtpClient("smtp.gmail.com", 587)
                {
                    EnableSsl = true,
                    Credentials = new NetworkCredential("lgk7878@gmail.com", "jadw gisb owfz hwws")
                };

                client.Send(msg);
                Console.WriteLine("Reminder email sent successfully.");
            }
            catch (SmtpException ex)
            {
                Console.WriteLine($"Failed to send reminder email: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
            }
        }

        /*
        private CalendarService GetCalendarService(string keyfilepath, string studentEmail)
        {
            try
            {
                string keyFilePath = Server.MapPath("~/App_Data/" + keyfilepath);

                string[] Scopes = {
            CalendarService.Scope.Calendar,
            CalendarService.Scope.CalendarEvents,
            CalendarService.Scope.CalendarEventsReadonly
        };

                GoogleCredential credential;
                using (var stream = new FileStream(keyfilepath, FileMode.Open, FileAccess.Read))
                {
                    // As we are using admin SDK, we need to still impersonate user who has admin access
                    // https://developers.google.com/admin-sdk/directory/v1/guides/delegation
                    credential = GoogleCredential.FromStream(stream)
                        .CreateScoped(Scopes).CreateWithUser(studentEmail);
                }

                // Create Calendar API service.
                var service = new CalendarService(new BaseClientService.Initializer()
                {
                    HttpClientInitializer = credential,
                    ApplicationName = "Calendar Sample",
                });
                return service;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        private void CreateEvent(CalendarService _service, string studentEmail, string eventName, string dateTime, string eventDesc)
        {
            Event body = new Event();
            EventDateTime start = new EventDateTime();
            start.DateTime = Convert.ToDateTime(dateTime);
            EventDateTime end = new EventDateTime();
            end.DateTime = Convert.ToDateTime(dateTime);
            body.Start = start;
            body.End = end;
            body.Summary = eventName;
            EventsResource.InsertRequest request = new EventsResource.InsertRequest(_service, body, studentEmail);
            Event response = request.Execute();
        }
        */
        public void AddEventToGoogleCalendar(string studentEmail, string studentID, string eventName, string dateTime, string eventDesc)
        {
            // Set up your Google OAuth 2.0 credentials
            string[] Scopes = { CalendarService.Scope.Calendar };
            string ApplicationName = "One-Stop Student System";
            UserCredential credential;

            // Replace the file path as needed
            string credentialsPath = Server.MapPath("~/credentials.json");
            string redirectUri = "https://localhost:44355/GLCallback.aspx"; // Ensure this matches the URI registered in Google Cloud Console

            using (var stream = new FileStream(credentialsPath, FileMode.Open, FileAccess.Read))
            {
                string credPath = Server.MapPath("~/token.json");
                Console.WriteLine("Using redirect URI: " + redirectUri); // Log the redirect URI
                credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                    GoogleClientSecrets.FromStream(stream).Secrets,
                    Scopes,
                    "user",
                    CancellationToken.None,
                    new FileDataStore(credPath, true)).Result;
                Console.WriteLine("Credential file saved to: " + credPath);
            }

            // Create Google Calendar API service.
            var service = new CalendarService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = ApplicationName,
            });

            // Define event details
            var evnt = new Google.Apis.Calendar.v3.Data.Event()
            {
                Summary = eventName,
                Description = eventDesc,
                Start = new EventDateTime()
                {
                    DateTime = DateTime.Parse(dateTime),
                    TimeZone = "Asia/Kuala_Lumpur",
                },
                End = new EventDateTime()
                {
                    DateTime = DateTime.Parse(dateTime).AddHours(1),
                    TimeZone = "Asia/Kuala_Lumpur",
                }
            };

            // Insert event to primary calendar
            var calendarId = "primary";
            var request = service.Events.Insert(evnt, calendarId);
            request.Execute();
        }
        

        private string GenerateNextID()
        {
            string newID = "RM001";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT TOP 1 ReminderID FROM Reminder ORDER BY CAST(SUBSTRING(ReminderID, 3, LEN(ReminderID)-2) AS INT) DESC", conn);
                    var result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        string lastID = result.ToString();
                        int num = int.Parse(lastID.Substring(2)) + 1;
                        newID = "RM" + num.ToString("D3");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while generating new ID: " + ex.Message);
            }

            return newID;
        }

        protected void GridView7_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView7.EditIndex = e.NewEditIndex;
            GridView7.DataBind();
            Console.WriteLine("GridView7_RowEditing: EditIndex set to " + e.NewEditIndex);
        }

        protected void GridView7_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView7.Rows[e.RowIndex];
            string reminderID = GridView7.DataKeys[e.RowIndex].Values["ReminderID"].ToString();
            string dateTime = ((TextBox)row.Cells[1].Controls[0]).Text;
            string eventName = ((TextBox)row.Cells[2].Controls[0]).Text;
            string eventDesc = ((TextBox)row.Cells[3].Controls[0]).Text;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Reminder SET dateTime = @dateTime, eventName = @eventName, eventDesc = @eventDesc WHERE ReminderID = @ReminderID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@dateTime", dateTime);
                        command.Parameters.AddWithValue("@eventName", eventName);
                        command.Parameters.AddWithValue("@eventDesc", eventDesc);
                        command.Parameters.AddWithValue("@ReminderID", reminderID);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }

                GridView7.EditIndex = -1;
                GridView7.DataBind();
                Console.WriteLine("GridView7.DataBind() called after updating reminder.");
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Failed to update reminder: {ex.Message}');", true);
            }
        }

        protected void GridView7_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView7.EditIndex = -1;
            GridView7.DataBind();
            Console.WriteLine("GridView7_RowCancelingEdit: EditIndex reset to -1.");
        }

        protected void GridView7_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string reminderID = GridView7.DataKeys[e.RowIndex].Values["ReminderID"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Reminder WHERE ReminderID = @ID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ID", reminderID);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                GridView7.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Failed to delete reminder: {ex.Message}');", true);
            }
        }
    }
}
