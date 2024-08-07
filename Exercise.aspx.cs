using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using Quartz;
using Quartz.Impl;
using System.Threading.Tasks;
using static OneStopStudentSystem.Exercise;
using fyp;
using System.Net;
using System.Threading;
using System.Web.Services;

namespace OneStopStudentSystem
{
    public partial class Exercise : System.Web.UI.Page
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
            ScheduleExerciseReminderJob(Session["UserID"].ToString());
        }

        private void ScheduleExerciseReminderJob(string studentID)
        {
            IScheduler scheduler = StdSchedulerFactory.GetDefaultScheduler().Result;
            scheduler.Start().Wait();

            IJobDetail job = JobBuilder.Create<ExerciseReminderJob>()
                .UsingJobData("StudentID", studentID)
                .Build();

            ITrigger trigger = TriggerBuilder.Create()
                .WithSimpleSchedule(x => x.WithIntervalInMinutes(60).RepeatForever()) // Adjust the interval as needed
                .Build();

            scheduler.ScheduleJob(job, trigger).Wait();
        }

        [System.Web.Services.WebMethod]
        public static string SaveIntoExerciseSchedule(string day, string time, string name)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = HttpContext.Current.Session["UserID"].ToString();
            string newEXID = GenerateNextID();
            int count = 0;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open(); 
                string query = "SELECT COUNT(*) FROM ExerciseSchedule WHERE day = @Day AND time = @TimeSlot AND studentID = @StudentID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Day", day);
                    cmd.Parameters.AddWithValue("@TimeSlot", time);
                    cmd.Parameters.AddWithValue("@StudentID", studentID);

                    count = (int)cmd.ExecuteScalar();
                }
            }
            if (count <= 0)
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = "INSERT INTO ExerciseSchedule (exerciseID, exerciseName, day, time, studentID) VALUES (@ID, @name, @day, @time, @StudentID)";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@ID", newEXID);
                            command.Parameters.AddWithValue("@name", name);
                            command.Parameters.AddWithValue("@day", day);
                            command.Parameters.AddWithValue("@time", time);
                            command.Parameters.AddWithValue("@StudentID", studentID);

                            connection.Open();
                            command.ExecuteNonQuery();
                        }
                    }
                    // Send a reminder email after saving the exercise schedule
                    ExerciseSchedule newSchedule = new ExerciseSchedule { Day = day, Time = time, ExerciseName = name };
                    ExerciseReminderJob.SendEmailReminder(studentID, newSchedule);

                    return "Data saved successfully.";
                }
                catch (Exception ex)
                {
                    return "An error occurred while saving data: " + ex.Message;
                }
            }
            else
            {
                string exerciseID = "";
                string exerciseName = "";

                // First SQL query to get exerciseID and exerciseName
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query1 = "SELECT exerciseID, exerciseName FROM ExerciseSchedule WHERE day = @Day AND time = @TimeSlot AND studentID = @StudentID";
                    using (SqlCommand cmd = new SqlCommand(query1, conn))
                    {
                        cmd.Parameters.AddWithValue("@Day", day);
                        cmd.Parameters.AddWithValue("@TimeSlot", time);
                        cmd.Parameters.AddWithValue("@StudentID", studentID);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                exerciseID = reader["exerciseID"].ToString();
                                exerciseName = reader["exerciseName"].ToString();
                            }
                        }
                    }
                }

                // Second SQL query to update the exerciseName
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE ExerciseSchedule SET exerciseName = @name WHERE exerciseID = @exerciseID AND studentID = @StudentID AND day=@day AND time=@time";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@exerciseID", exerciseID);
                        command.Parameters.AddWithValue("@name", exerciseName);
                        command.Parameters.AddWithValue("@day", day);
                        command.Parameters.AddWithValue("@time", time);
                        command.Parameters.AddWithValue("@StudentID", studentID);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }

                return "EXISTS";
            }

        }
        [WebMethod]
        public static string ReplaceExercise(string day, string time, string name)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = HttpContext.Current.Session["UserID"].ToString();
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE ExerciseSchedule SET exerciseName = @name, day = @day, time = @time WHERE studentID = @StudentID AND day = @day AND time = @time";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@name", name);
                        command.Parameters.AddWithValue("@day", day);
                        command.Parameters.AddWithValue("@time", time);
                        command.Parameters.AddWithValue("@StudentID", studentID);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                // Send a reminder email after replacing the exercise schedule
                ExerciseSchedule newSchedule = new ExerciseSchedule { Day = day, Time = time, ExerciseName = name };
                ExerciseReminderJob.SendEmailReminder(studentID, newSchedule);

                return "Data replaced successfully.";
            }
            catch (Exception ex)
            {
                return "An error occurred while replacing data: " + ex.Message;
            }
        }

        private static string GenerateNextID()
        {
            string newID = "ES001";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT TOP 1 exerciseID FROM ExerciseSchedule ORDER BY exerciseID DESC", conn);
                    var result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        string lastID = result.ToString();
                        int num = int.Parse(lastID.Substring(2)) + 1;
                        newID = "ES" + num.ToString("D3");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while generating new ID: " + ex.Message);
            }

            return newID;
        }

        [System.Web.Services.WebMethod]
        public static List<ExerciseSchedule> GetSavedExercises()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = HttpContext.Current.Session["UserID"].ToString();
            List<ExerciseSchedule> exercises = new List<ExerciseSchedule>();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT day, time, exerciseName FROM ExerciseSchedule WHERE studentID = @StudentID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@StudentID", studentID);
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                exercises.Add(new ExerciseSchedule
                                {
                                    Day = reader["day"].ToString(),
                                    Time = reader["time"].ToString(),
                                    ExerciseName = reader["exerciseName"].ToString()
                                });
                            }
                        }
                    }
                    //sentEmail(Day, Time, ExerciseName); //how get 
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while retrieving data: " + ex.Message);
            }

            return exercises;
        }
    }

    public class ExerciseReminderJob : IJob
    {
        public async Task Execute(IJobExecutionContext context)
        {
            string studentID = context.MergedJobDataMap.GetString("StudentID");

            try
            {
                // Retrieve the user's exercise schedule
                List<ExerciseSchedule> schedule = GetExerciseSchedule(studentID);

                // Send reminders for today's exercises
                DateTime currentTime = DateTime.Now;
                string today = currentTime.DayOfWeek.ToString();

                foreach (var item in schedule)
                {
                    if (item.Day.Equals(today, StringComparison.OrdinalIgnoreCase))
                    {
                        TimeSpan exerciseStartTime = TimeSpan.Parse(item.Time.Split('-')[0].Trim());
                        DateTime exerciseDateTime = DateTime.Today + exerciseStartTime;

                        // Send a reminder email 1 hour before the exercise start time
                        DateTime reminderTime = exerciseDateTime - TimeSpan.FromMinutes(60);
                        if (currentTime < exerciseDateTime && currentTime >= reminderTime)
                        {
                            SendEmailReminder(studentID, item);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error sending exercise reminders: " + ex.Message);
            }
        }


        public static void SendEmailReminder(string studentID, ExerciseSchedule item)
        {
            string studentEmail = GetStudentEmail(studentID);

            if (!string.IsNullOrEmpty(studentEmail))
            {
                try
                {
                    using (MailMessage mail = new MailMessage())
                    {
                        mail.From = new MailAddress("lgk7878@gmail.com");
                        mail.To.Add(studentEmail);
                        mail.Subject = "Exercise Reminder";
                        mail.Body = $"Reminder: You have a {item.ExerciseName} scheduled at {item.Time} on {item.Day}.";
                        mail.IsBodyHtml = true;

                        using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                        {
                            smtp.Credentials = new System.Net.NetworkCredential("lgk7878@gmail.com", "jadw gisb owfz hwws");
                            smtp.EnableSsl = true;

                            Console.WriteLine("Sending email...");
                            smtp.Send(mail);
                            Console.WriteLine("Email sent successfully.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("An error occurred while sending email: " + ex.Message);
                }
            }
            else
            {
                Console.WriteLine("Student email is empty.");
            }
        }

        private static List<ExerciseSchedule> GetExerciseSchedule(string studentID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            List<ExerciseSchedule> schedule = new List<ExerciseSchedule>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT exerciseName, day, time FROM ExerciseSchedule WHERE studentID = @StudentID";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentID", studentID);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        schedule.Add(new ExerciseSchedule
                        {
                            ExerciseName = reader["exerciseName"].ToString(),
                            Day = reader["day"].ToString(),
                            Time = reader["time"].ToString()
                        });
                    }
                }
            }
            return schedule;
        }

        private static string GetStudentEmail(string studentID)
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

        private static DateTime GetNextDayOfWeek(string day, TimeSpan time)
        {
            DayOfWeek dayOfWeek = (DayOfWeek)Enum.Parse(typeof(DayOfWeek), day, true);
            DateTime result = DateTime.Now;
            while (result.DayOfWeek != dayOfWeek)
            {
                result = result.AddDays(1);
            }
            return result.Date + time;
        }

        private static int GetDayIndex(string dayName)
        {
            switch (dayName)
            {
                case "Monday": return 0;
                case "Tuesday": return 1;
                case "Wednesday": return 2;
                case "Thursday": return 3;
                case "Friday": return 4;
                case "Saturday": return 5;
                case "Sunday": return 6;
                default: throw new ArgumentException("Invalid day name");
            }
        }
    }
}
