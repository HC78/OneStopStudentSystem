using System;
using System.Configuration;
using System.Data.SqlClient;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Calendar.v3;
using Google.Apis.Calendar.v3.Data;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using System.Web.UI;
using System.Xml.Linq;
using System.Net.Mail;
using System.Net;
using System.Web.UI.WebControls;
using System.Diagnostics.Eventing.Reader;
using Newtonsoft.Json.Linq;
using System.Threading;


namespace fyp
{
    public partial class ReminderTest : System.Web.UI.Page
    {
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
                StoreOriginalValues();
            }
            CalendarExtender1.StartDate = DateTime.Now.Date;

        }

        //dk yet StoreOriginalValues
        private void StoreOriginalValues()
        {
            foreach (GridViewRow row in GridView7.Rows)
            {
                TextBox txtEventName = (TextBox)row.FindControl("txtEventName");
                TextBox txtEventDesc = (TextBox)row.FindControl("txtEventDesc");
                TextBox txtTime = (TextBox)row.FindControl("txtTime");

                if (txtEventName != null && txtEventDesc != null)
                {
                    string eventName = txtEventName.Text;
                    string eventDesc = txtEventDesc.Text;
                    string eventMin = txtTime.Text;

                    ViewState["OriginalEventName"] = eventName;
                    ViewState["OriginalEventDesc"] = eventDesc;
                    ViewState["OriginalReminderTime"] = eventMin;

                    break;
                }
                else
                {
                    Console.WriteLine("Error: One or more controls were not found in the GridViewRow.");
                }
            }
        }


        protected void BtnCreateEvent_Click(object sender, EventArgs e)
        {
            string reminderID = "";
            string eventName = txtEventName.Text;
            string eventDesc = txtEventDesc.Text;
            DateTime eventDate;


            if (DateTime.TryParse(txtEventDate.Text, out eventDate))
            {
                if (eventDate <= DateTime.Now)
                {
                    lblMessage.Text = "Event date time must be greater than now.";
                    lblMessage.Visible = true;
                    return;
                }

                string userId = Session["UserID"].ToString();
                string studentEmail = GetStudentEmail(userId);
                string accessToken = GetAccessToken(userId);

                reminderID = AddReminderToDatabase(txtEventDate.Text, txtEventDesc.Text, txtEventName.Text, txtTime.Text);
                GridView7.DataBind();
                SendReminderEmail(studentEmail, txtEventName.Text, txtEventDate.Text, txtEventDesc.Text);

                // Send reminder x min before event start
                int reminderMinutes;
                if (int.TryParse(txtTime.Text, out reminderMinutes))
                {
                    DateTime reminderTime = eventDate.AddMinutes(-reminderMinutes);
                    // Schedule the reminder only if it is in the future
                    if (reminderTime > DateTime.Now)
                    {
                        ScheduleReminder(reminderTime, studentEmail, eventName, eventDesc, txtEventDate.Text, reminderID, txtTime.Text);
                        lblPass.Visible = false;
                    }
                    else
                    {
                        lblPass.Text = "Reminder time has already passed. No reminder will be send again to remind before event start.";
                        lblPass.Visible = true;
                    }
                }
                else
                {
                    lblMessage.Text = "Please enter a valid number for reminder minutes.";
                    lblMessage.Visible = true;
                }

                if (!string.IsNullOrEmpty(accessToken))
                {
                    try
                    {
                        CreateGoogleCalendarEvent(accessToken, eventName, eventDesc, eventDate);
                        lblMessage.Text = "Event created successfully!";
                        lblMessage.Visible = true;
                        GridView7.DataBind();
                        txtEventDate.Text = string.Empty;
                        txtEventDesc.Text = string.Empty;
                        txtEventName.Text = string.Empty;
                        txtTime.Text = string.Empty;
                        CheckReminder(noReminderMsg);
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = $"Failed to create event: {ex.Message}";
                        lblMessage.Visible = true;
                    }
                }
                else
                {
                    lblMessage.Text = "Failed to retrieve access token.";
                    lblMessage.Visible = true;
                }
            }
            else
            {
                lblMessage.Text = "Invalid date format. Please enter according format: MM-dd-yyyy HH:mm:ss (ex: 07-16-2024 00:29:07)";
                lblMessage.Visible = true;
            }

        }


        private void ScheduleReminder(DateTime reminderTime, string toEmail, string subject, string body, string oriDateTime, string reminderID, string min)
        {
            TimeSpan delay = reminderTime - DateTime.Now;
            bool eventSame = CheckIfEventDetailSame(reminderID, subject, body, oriDateTime, min);

            // Check if the reminder time is in the future
            if (delay.TotalMilliseconds > 0)
            {
                // Using a timer to send reminder at specified time
                System.Threading.Timer reminderTimer = new System.Threading.Timer((state) =>
                {
                    if (eventSame)
                    {
                        SendReminderEmailAgain(toEmail, subject, oriDateTime, body);
                    }
                    else
                    {
                        return;
                    }
                }, null, delay, TimeSpan.Zero);
                lblPass.Visible = false;
            }
            else
            {
                lblPass.Text = "Reminder time has already passed. No reminder will be send again to remind before event start.";
                lblPass.Visible = true;
            }
        }

        private bool CheckIfEventDetailSame(string reminderID, string eventName, string eventDesc, string dateTime, string eventReminderTime)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            bool isSame = false;
            string dbEventName = "";
            string dbEventDesc = "";
            //  string dbDateTime = "";
            string dbReminderTime = "";
            DateTime dbDateTime = DateTime.MinValue;
            DateTime inputDateTime = DateTime.MinValue;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT eventName, eventDesc, dateTime, reminderTime FROM Reminder WHERE ReminderID = @ReminderID", conn);
                    cmd.Parameters.AddWithValue("@ReminderID", reminderID);

                    Console.WriteLine("Executing SQL Command: " + cmd.CommandText);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                dbEventName = reader.IsDBNull(reader.GetOrdinal("eventName")) ? string.Empty : reader["eventName"].ToString();
                                dbEventDesc = reader.IsDBNull(reader.GetOrdinal("eventDesc")) ? string.Empty : reader["eventDesc"].ToString();
                                dbReminderTime = reader.IsDBNull(reader.GetOrdinal("reminderTime")) ? string.Empty : reader["reminderTime"].ToString();

                                DateTime.TryParse(reader["dateTime"].ToString(), out dbDateTime);
                                DateTime.TryParse(dateTime, out inputDateTime);
                                string normalizedDbDateTime = dbDateTime.ToString("yyyy-MM-dd HH:mm:ss");
                                string normalizedInputDateTime = inputDateTime.ToString("yyyy-MM-dd HH:mm:ss");

                                isSame = dbEventName == eventName && dbEventDesc == eventDesc && normalizedDbDateTime == normalizedInputDateTime && dbReminderTime == eventReminderTime;
                            }
                        }
                        else
                        {
                            Console.WriteLine("No rows found for ReminderID: " + reminderID);
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                Console.WriteLine("SQL Error: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("General Error: " + ex.Message);
            }

            return isSame;
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
        private string AddReminderToDatabase(string dateTime, string desc, string name, string reminderTime)
        {
            if (string.IsNullOrWhiteSpace(dateTime) || string.IsNullOrWhiteSpace(name))
            {
                string alertMessage = "Please provide valid information for the reminder.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}');", true);
                return null;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();
            string newReminderID = GenerateNextID();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Reminder (ReminderID, eventName, eventDesc, studentID, dateTime, reminderTime) " +
                          "VALUES (@ID, @name, @desc, @studentID, @dateTime, @reminderTime); " +
                          "SELECT @ID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ID", newReminderID);
                        command.Parameters.AddWithValue("@name", name);
                        command.Parameters.AddWithValue("@desc", desc);
                        command.Parameters.AddWithValue("@studentID", studentID);
                        command.Parameters.AddWithValue("@dateTime", dateTime);
                        command.Parameters.AddWithValue("@reminderTime", reminderTime);

                        connection.Open();

                        object result = command.ExecuteScalar();

                        if (result != null)
                        {
                            return result.ToString();
                        }
                        else
                        {
                            Console.WriteLine("Failed to retrieve the new ReminderID.");
                            return null;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Failed to add reminder: {ex.Message}');", true);
                return null;
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

        protected void SendReminderEmailAgain(string toEmail, string eventName, string dateTime, string eventDesc)
        {
            try
            {
                // Create the mail message
                MailMessage msg = new MailMessage();
                msg.To.Add(toEmail);
                msg.From = new MailAddress("lgk7878@gmail.com");
                msg.Subject = $"Reminder: {eventName}";
                msg.Body = $"Dear Student, \n\n We would like to remind you again that you have a reminder for '{eventName}' scheduled on {dateTime}.\n\nEvent Description: {eventDesc}";

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

        private string GetAccessToken(string userId)
        {
            string accessToken = null;
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT AccessToken FROM Student WHERE studentID = @StudentID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentID", userId);
                    connection.Open();
                    var result = command.ExecuteScalar();
                    if (result != null)
                    {
                        accessToken = result.ToString();
                    }
                }
            }

            return accessToken;
        }

        private void CreateGoogleCalendarEvent(string accessToken, string eventName, string eventDesc, DateTime eventDate)
        {
            var credential = GoogleCredential.FromAccessToken(accessToken)
                              .CreateScoped(new[] { CalendarService.Scope.Calendar });

            var service = new CalendarService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "OneStopStudentSystem"
            });

            var newEvent = new Event()
            {
                Summary = eventName,
                Description = eventDesc,
                Start = new EventDateTime()
                {
                    DateTime = eventDate,
                    TimeZone = "Asia/Kuala_Lumpur"
                },
                End = new EventDateTime()
                {
                    DateTime = eventDate.AddHours(1),
                    TimeZone = "Asia/Kuala_Lumpur"
                }
            };

            EventsResource.InsertRequest request = service.Events.Insert(newEvent, "primary");
            request.Execute();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtEventDate.Text = string.Empty;
            txtEventDesc.Text = string.Empty;
            txtEventName.Text = string.Empty;
            txtTime.Text = string.Empty;
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
            string reminderMin = ((TextBox)row.Cells[4].Controls[0]).Text;

            string oldEventName = ViewState["OriginalEventName"] as string;
            string oldEventDesc = ViewState["OriginalEventDesc"] as string;
            string oldDateTime = ViewState["OriginalReminderTime"] as string;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Reminder SET dateTime = @dateTime, eventName = @eventName, eventDesc = @eventDesc, reminderTime=@reminderTime WHERE ReminderID = @ReminderID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@dateTime", dateTime);
                        command.Parameters.AddWithValue("@eventName", eventName);
                        command.Parameters.AddWithValue("@eventDesc", eventDesc);
                        command.Parameters.AddWithValue("@ReminderID", reminderID);
                        command.Parameters.AddWithValue("@reminderTime", reminderMin);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }

                string studentID = Session["UserID"].ToString();
                string studentEmail = GetStudentEmail(studentID);
                SendReminderUpdatedEmail(studentEmail, eventName, dateTime, eventDesc);

                int reminderMinutes;
                DateTime eventDateTime;
                if (int.TryParse(reminderMin, out reminderMinutes) && DateTime.TryParse(dateTime, out eventDateTime))
                {
                    DateTime reminderTime = eventDateTime.AddMinutes(-reminderMinutes);

                    TimeSpan delay = reminderTime - DateTime.Now;

                    // Check if the reminder time is in the future
                    if (delay.TotalMilliseconds > 0)
                    {
                        // Using a timer to send reminder at specified time
                        System.Threading.Timer reminderTimer = new System.Threading.Timer((state) =>
                        {
                            // Check if the event with the reminder still exists
                            bool eventExists = CheckIfEventExists(reminderID);
                            if (eventExists)
                            {
                                if (reminderTime > DateTime.Now)
                                {
                                    SendReminderUpdatedEmailAgain(studentEmail, eventName, dateTime, eventDesc); //to, name, dateTime, desc
                                    lblPass.Visible = false;
                                }
                                else
                                {
                                    lblPass.Text = "Reminder time has already passed. No reminder will be send again to remind before event start.";
                                    lblPass.Visible = true;
                                }
                            }
                            else
                            {
                                Console.WriteLine($"Event associated with reminder ID '{reminderID}' no longer exists. No reminder email will be sent.");
                            }
                        }, null, delay, TimeSpan.Zero);
                        lblPass.Visible = false;
                    }
                    else
                    {
                        lblPass.Text = "Reminder time has already passed. No reminder will be send again to remind before event start.";
                        lblPass.Visible = true;
                    }
                }

                GridView7.EditIndex = -1;
                GridView7.DataBind();
                lblMessage.Text = "Reminder updated successfully!";
                lblMessage.Visible = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Failed to update reminder: {ex.Message}');", true);
            }
        }

        protected void SendReminderUpdatedEmailAgain(string toEmail, string eventName, string dateTime, string eventDesc)
        {
            try
            {
                // Create the mail message
                MailMessage msg = new MailMessage();
                msg.To.Add(toEmail);
                msg.From = new MailAddress("lgk7878@gmail.com");
                msg.Subject = $"Reminder: {eventName}";
                msg.Body = $"Dear Student, \n\n We would like to remind you again that you have an updated reminder for '{eventName}' scheduled on {dateTime}.\n\nEvent Description: {eventDesc}";

                // Configure the SMTP client
                SmtpClient client = new SmtpClient("smtp.gmail.com", 587)
                {
                    EnableSsl = true,
                    Credentials = new NetworkCredential("lgk7878@gmail.com", "jadw gisb owfz hwws")
                };

                client.Send(msg);
                Console.WriteLine("Reminder updated email sent successfully.");
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
        protected void SendReminderUpdatedEmail(string toEmail, string eventName, string dateTime, string eventDesc)
        {
            try
            {
                // Create the mail message
                MailMessage msg = new MailMessage();
                msg.To.Add(toEmail);
                msg.From = new MailAddress("lgk7878@gmail.com");
                msg.Subject = $"Reminder: {eventName}";
                msg.Body = $"Dear Student, \n\n We would like to remind you that you have an updated reminder for '{eventName}' scheduled on {dateTime}.\n\nEvent Description: {eventDesc}";

                // Configure the SMTP client
                SmtpClient client = new SmtpClient("smtp.gmail.com", 587)
                {
                    EnableSsl = true,
                    Credentials = new NetworkCredential("lgk7878@gmail.com", "jadw gisb owfz hwws")
                };

                client.Send(msg);
                Console.WriteLine("Reminder updated email sent successfully.");
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

        protected void GridView7_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView7.EditIndex = -1;
            GridView7.DataBind();
            Console.WriteLine("GridView7_RowCancelingEdit: EditIndex reset to -1.");
        }

        private bool CheckIfEventExists(string reminderID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            bool eventExists = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Reminder WHERE ReminderID = @ReminderID", conn);
                    cmd.Parameters.AddWithValue("@ReminderID", reminderID);

                    int reminderCount = (int)cmd.ExecuteScalar();
                    eventExists = (reminderCount > 0);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while checking if event exists: " + ex.Message);
            }

            return eventExists;
        }

        protected void GridView7_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string reminderID = GridView7.DataKeys[e.RowIndex].Values["ReminderID"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                bool eventExists = CheckIfEventExists(reminderID);

                if (eventExists)
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = "SELECT eventName, dateTime FROM Reminder WHERE ReminderID = @ID";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@ID", reminderID);

                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();

                            if (reader.Read())
                            {
                                string eventName = reader["eventName"].ToString();
                                DateTime eventDateTime = Convert.ToDateTime(reader["dateTime"]);

                                reader.Close();

                                string accessToken = GetAccessToken(Session["UserID"].ToString());
                                if (!string.IsNullOrEmpty(accessToken))
                                {
                                    DeleteGoogleCalendarEvent(accessToken, eventName, eventDateTime);
                                }

                                query = "DELETE FROM Reminder WHERE ReminderID = @ID";
                                command.CommandText = query;
                                command.Parameters.Clear();
                                command.Parameters.AddWithValue("@ID", reminderID);
                                command.ExecuteNonQuery();
                                lblMessage.Text = "Event deleted successfully!";
                                lblMessage.Visible = true;
                                GridView7.DataBind();

                                string studentID = Session["UserID"].ToString();
                                string studentEmail = GetStudentEmail(studentID);
                                //  SendDeletionConfirmationEmail(studentEmail, eventName, eventDateTime);
                            }
                            else
                            {
                                Console.WriteLine($"Reminder with ID {reminderID} not found.");
                            }
                        }
                    }

                    GridView7.DataBind();
                }
                else
                {
                    Console.WriteLine($"Event with ID {reminderID} does not exist.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Failed to delete reminder: {ex.Message}');", true);
            }
        }

        //dk
        private void SendDeletionConfirmationEmail(string toEmail, string eventName, string eventDateTime)
        {
            try
            {
                MailMessage msg = new MailMessage();
                msg.To.Add(toEmail);
                msg.From = new MailAddress("lgk7878@gmail.com");
                msg.Subject = $"Reminder Deleted: {eventName}";
                msg.Body = $"Dear Student,\n\nThe reminder for '{eventName}' scheduled on {eventDateTime} has been deleted.\n\nIf you didn't request this deletion, please contact support immediately.";

                SmtpClient client = new SmtpClient("smtp.gmail.com", 587)
                {
                    EnableSsl = true,
                    Credentials = new NetworkCredential("lgk7878@gmail.com", "jadw gisb owfz hwws")
                };

                client.Send(msg);
                Console.WriteLine("Deletion confirmation email sent successfully.");
            }
            catch (SmtpException ex)
            {
                Console.WriteLine($"Failed to send deletion confirmation email: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
            }
        }
        private void DeleteGoogleCalendarEvent(string accessToken, string eventName, DateTime eventDateTime)
        {
            var credential = GoogleCredential.FromAccessToken(accessToken)
                              .CreateScoped(new[] { CalendarService.Scope.Calendar });

            var service = new CalendarService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "OneStopStudentSystem"
            });

            EventsResource.ListRequest request = service.Events.List("primary");
            request.TimeMin = eventDateTime.AddMinutes(-1); // Adjusted to slightly earlier to ensure retrieval
            request.TimeMax = eventDateTime.AddMinutes(1);  // Adjusted to slightly later to ensure retrieval
            request.Q = eventName;

            Events events = request.Execute();
            if (events.Items != null && events.Items.Count > 0)
            {
                foreach (var eventItem in events.Items)
                {
                    service.Events.Delete("primary", eventItem.Id).Execute();
                }
            }
        }
    }
}