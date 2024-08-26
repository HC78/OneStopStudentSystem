using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OneStopStudentSystem
{
    public partial class BMI : System.Web.UI.Page
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

            if (!IsPostBack)
            {

                string BMI = hiddenBMI.Value;
                string weight = hiddenWeight.Value;
                string height = hiddenHeight.Value;
                if (!string.IsNullOrEmpty(BMI))
                {
                    btnSave.Visible = true;
                }
            }
        }

        protected void SaveIntoHealthyValue()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();
            string newHealthID = GenerateNextID();

            string BMI = hiddenBMI.Value;
            string weight = hiddenWeight.Value;
            string height = hiddenHeight.Value;

            if (!string.IsNullOrEmpty(BMI))
            {
                decimal maintenanceCalories = Convert.ToDecimal(BMI);

                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = "INSERT INTO HealthyValue (healthID, dateTime, BMIValue, CalorieValue, Height, Weight, studentID) VALUES (@ID, @dateTime, @BMI, @Calorie, @height, @weight, @StudentID)";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@ID", newHealthID);
                            command.Parameters.AddWithValue("@dateTime", DateTime.Now.ToString());
                            command.Parameters.AddWithValue("@BMI",BMI);
                            command.Parameters.AddWithValue("@Calorie", DBNull.Value);
                            command.Parameters.AddWithValue("@height", height);
                            command.Parameters.AddWithValue("@weight", weight);
                            command.Parameters.AddWithValue("@StudentID", studentID);

                            connection.Open();
                            command.ExecuteNonQuery();
                        }
                    }
                    compareBMI();
                    GridView1.DataBind();
                    lblMessage.Text = "Data saved successfully.";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred while saving data: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblMessage.Text = "BMI value is missing.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }


        private string GenerateNextID()
        {
            string newID = "H0001";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT TOP 1 healthID FROM HealthyValue ORDER BY healthID DESC", conn);
                    var result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        string lastID = result.ToString();
                        int num = int.Parse(lastID.Substring(2)) + 1;
                        newID = "H" + num.ToString("D4");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while generating new ID: " + ex.Message);
            }

            return newID;
        }

        private void compareBMI()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = HttpContext.Current.Session["UserID"].ToString();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Get the latest record
                    string queryLatest = @"
                SELECT TOP 1 Weight, BMIValue
                FROM HealthyValue
                WHERE studentID = @StudentID AND BMIValue IS NOT NULL
                ORDER BY dateTime DESC";

                    SqlCommand commandLatest = new SqlCommand(queryLatest, connection);
                    commandLatest.Parameters.AddWithValue("@StudentID", studentID);

                    SqlDataReader readerLatest = commandLatest.ExecuteReader();
                    if (readerLatest.Read())
                    {
                        decimal latestWeight = readerLatest.GetDecimal(0);
                        decimal latestBMI = readerLatest.GetDecimal(1);
                        readerLatest.Close();

                        // Get the previous record
                        string queryPrevious = @"
                    SELECT TOP 1 Weight, BMIValue
                    FROM HealthyValue
                    WHERE studentID = @StudentID AND BMIValue IS NOT NULL
                    AND dateTime < (
                        SELECT MAX(dateTime)
                        FROM HealthyValue
                        WHERE studentID = @StudentID  AND BMIValue IS NOT NULL)
                    ORDER BY dateTime DESC";

                        SqlCommand commandPrevious = new SqlCommand(queryPrevious, connection);
                        commandPrevious.Parameters.AddWithValue("@StudentID", studentID);

                        SqlDataReader readerPrevious = commandPrevious.ExecuteReader();
                        if (readerPrevious.Read())
                        {
                            decimal previousWeight = readerPrevious.GetDecimal(0);
                            decimal previousBMI = readerPrevious.GetDecimal(1);

                            if (previousBMI < 18.5m) // Underweight
                            {
                                if (latestWeight > previousWeight)
                                {
                                    lblCong.Text = "Congratulations! You have increased your weight from underweight ( " + previousWeight + "kg -> " + latestWeight + "kg ) keep it up!";
                                    lblCong.CssClass = "glow-bold";
                                }
                                else
                                {
                                    lblCong.Text = "Unfortunately, You have decreased your weight from underweight ( " + previousWeight + "kg -> " + latestWeight + "kg )";
                                    lblCong.CssClass = "glow-bold";
                                }
                            }
                            else if (previousBMI >= 30m) // Obese
                            {
                                if (latestWeight < previousWeight)
                                {
                                    lblCong.Text = "Congratulations! You have successfully reduced your weight from obese ( " + previousWeight + "kg -> " + latestWeight + "kg ) keep it up!";
                                    lblCong.CssClass = "glow-bold";
                                }
                                else
                                {
                                    lblCong.Text = "Unfortunately, You have increased your weight from obese ( " + previousWeight + "kg -> " + latestWeight + "kg )";
                                    lblCong.CssClass = "glow-bold";
                                }
                            }
                            else if (previousBMI >= 25m) // Overweight
                            {
                                if (latestWeight < previousWeight)
                                {
                                    lblCong.Text = "Congratulations! You have successfully reduced your weight from overweight ( " + previousWeight + "kg -> " + latestWeight + "kg ) keep it up!";
                                    lblCong.CssClass = "glow-bold";
                                }
                                else
                                {
                                    lblCong.Text = "Unfortunately, You have increased your weight from overweight ( " + previousWeight + "kg -> " + latestWeight + "kg )";
                                    lblCong.CssClass = "glow-bold";
                                }
                            }
                        }
                        else
                        {
                            lblCong.Text = "No previous record found for comparison.";
                        }
                    }
                    else
                    {
                        lblCong.Text = "No latest record found for comparison.";
                    }
                }
            }
            catch (Exception ex)
            {
                lblCong.Text = "An error occurred while comparing BMI data: " + ex.Message;
            }
        }


        //BELOW WRONG
        [WebMethod]
        public static string CompareBMI()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = HttpContext.Current.Session["UserID"].ToString();
            string message = "";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Get the latest record
                    string queryLatest = @"
                SELECT TOP 1 Weight, BMIValue
                FROM HealthyValue
                WHERE studentID = @StudentID
                ORDER BY dateTime DESC";

                    SqlCommand commandLatest = new SqlCommand(queryLatest, connection);
                    commandLatest.Parameters.AddWithValue("@StudentID", studentID);

                    SqlDataReader readerLatest = commandLatest.ExecuteReader();
                    if (readerLatest.Read())
                    {
                        decimal latestWeight = readerLatest.GetDecimal(0);
                        decimal latestBMI = readerLatest.GetDecimal(1);
                        readerLatest.Close();

                        // Get the previous record
                        string queryPreviousNo = @"
                    SELECT TOP 1 Weight, BMIValue
                    FROM HealthyValue
                    WHERE studentID = @StudentID AND BMIValue IS NOT NULL
                    AND dateTime < (
                        SELECT MAX(dateTime)
                        FROM HealthyValue
                        WHERE studentID = @StudentID AND BMIValue IS NOT NULL)
                    ORDER BY dateTime DESC";

                        string queryPrevious = @"
                             SELECT TOP 1 Weight, BMIValue
                    FROM HealthyValue
                    WHERE studentID = @StudentID AND BMIValue IS NOT NULL
                    AND dateTime < (
                        SELECT MAX(dateTime)
                        FROM HealthyValue
                        WHERE studentID = @StudentID AND BMIValue IS NOT NULL)
                    ORDER BY dateTime DESC";
                        SqlCommand commandPrevious = new SqlCommand(queryPrevious, connection);
                        commandPrevious.Parameters.AddWithValue("@StudentID", studentID);

                        SqlDataReader readerPrevious = commandPrevious.ExecuteReader();
                        if (readerPrevious.Read())
                        {
                            decimal previousWeight = readerPrevious.GetDecimal(0);
                            decimal previousBMI = readerPrevious.GetDecimal(1);

                            // Compare and generate message
                            if (previousBMI < 18.5m) // Underweight
                            {
                                if (latestWeight > previousWeight)
                                {
                                    message = "Congratulations! You have increased your weight from underweight, keep it up!";
                                }
                                else
                                {
                                    message = "So sad, strive to decrease weight from underweight";
                                }
                            }
                            else if (previousBMI >= 30m) // obese
                            {
                                if (latestWeight < previousWeight)
                                {
                                    message = "Congratulations! You have successfully reduced your weight from obese, keep it up!";
                                }
                            }
                            else if (previousBMI >= 25m) // Overweight
                            {
                                if (latestWeight < previousWeight)
                                {
                                    message = "Congratulations! You have successfully reduced your weight from overweight, keep it up!";
                                }
                            }
                        }
                        else
                        {
                            message = "No previous record found for comparison.";
                        }
                    }
                    else
                    {
                        message = "No latest record found for comparison.";
                    }
                }
            }
            catch (Exception ex)
            {
                message = "An error occurred while comparing BMI data: " + ex.Message;
            }

            return message;
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            string bmi = hiddenBMI.Value;
            if (!string.IsNullOrEmpty(bmi))
            {
                SaveIntoHealthyValue();
            }
            else
            {
                lblMessage.Text = "Please calculate the BMI first.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}