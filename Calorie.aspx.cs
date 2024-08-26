using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OneStopStudentSystem
{
    public partial class Calorie : System.Web.UI.Page
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

                string maintenanceCaloriesString = hiddenMaintenanceCalories.Value;
                string weight = hiddenWeight.Value;
                string height = hiddenHeight.Value;
                if (!string.IsNullOrEmpty(maintenanceCaloriesString))
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

            string maintenanceCaloriesString = hiddenMaintenanceCalories.Value;
            string weight = hiddenWeight.Value;
            string height = hiddenHeight.Value;
            string targetWeight = hiddenTargetWeight.Value;
            bool isTargetAchieved = false;
            if (!string.IsNullOrEmpty(maintenanceCaloriesString) && !string.IsNullOrEmpty(weight) && !string.IsNullOrEmpty(targetWeight))
            {
                decimal maintenanceCalories = Convert.ToDecimal(maintenanceCaloriesString);
                decimal previousWeight = GetPreviousWeight(studentID);
                decimal currentWeight = Convert.ToDecimal(weight);
                decimal targetWeight1 = Convert.ToDecimal(targetWeight);
                decimal previousTargetWeight = GetPreviousTargetWeight(studentID);

                string message = "";
                if (targetWeight1 == previousTargetWeight)
                {
                    if (currentWeight == targetWeight1)
                    {
                        message = "Congratulations! You have achieved your target weight, " + targetWeight1.ToString("F0") + " kg";
                        isTargetAchieved = true;
                    }
                    else if (Math.Abs(currentWeight - targetWeight1) < Math.Abs(previousWeight - targetWeight1))
                    {
                        message = "You are moving towards your target weight, " + targetWeight1.ToString("F0") + " kg from " + previousWeight.ToString("F0") + " kg -> " + currentWeight.ToString("F0") + " kg. Nice!";
                        isTargetAchieved = true;
                    }
                    else
                    {
                        message = "Sadly, you are further away from your target weight, " + targetWeight1.ToString("F0") + " kg than before (" + previousWeight.ToString("F0") + " kg -> " + currentWeight.ToString("F0") + " kg). Please keep it up.";
                        isTargetAchieved = false;
                    }

                    lblCong.Text = message;
                    lblCong.CssClass = "glow-bold";
                }
                else
                {
                    lblCong.Text = "";
                }
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = "INSERT INTO HealthyValue (healthID, dateTime, BMIValue, CalorieValue, Height, Weight, studentID, TargetWeight) VALUES (@ID, @dateTime, @BMI, @Calorie, @height, @weight, @StudentID, @targetWeight)";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@ID", newHealthID);
                            command.Parameters.AddWithValue("@dateTime", DateTime.Now.ToString());
                            command.Parameters.AddWithValue("@BMI", DBNull.Value);
                            command.Parameters.AddWithValue("@Calorie", maintenanceCalories);
                            command.Parameters.AddWithValue("@height", height);
                            command.Parameters.AddWithValue("@weight", weight);
                            command.Parameters.AddWithValue("@StudentID", studentID);
                            command.Parameters.AddWithValue("@targetWeight", targetWeight);
                            connection.Open();
                            command.ExecuteNonQuery();
                        }
                    }
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
                lblMessage.Text = "Maintenance calories value is missing.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
 
            //not work
            hiddenIsTargetAchieved.Value = isTargetAchieved.ToString().ToLower();

            ScriptManager.RegisterStartupScript(this, GetType(), "toggleNotice", "toggleNoticeVisibility();", false);
        }

        private decimal GetPreviousTargetWeight(string studentID)
        {
            decimal previousTargetWeight = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT TOP 1 TargetWeight FROM HealthyValue WHERE studentID = @StudentID AND CalorieValue IS NOT NULL ORDER BY dateTime DESC";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@StudentID", studentID);
                        connection.Open();
                        object result = command.ExecuteScalar();
                        if (result != null)
                        {
                            previousTargetWeight = Convert.ToDecimal(result);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while retrieving previous target weight: " + ex.Message);
            }

            return previousTargetWeight;
        }
        private decimal GetPreviousWeight(string studentID)
        {
            decimal previousWeight = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT TOP 1 Weight FROM HealthyValue WHERE studentID = @StudentID AND CalorieValue IS NOT NULL ORDER BY dateTime DESC";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@StudentID", studentID);
                    var result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        previousWeight = Convert.ToDecimal(result);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while fetching the previous weight: " + ex.Message);
            }

            return previousWeight;
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string maintenanceCaloriesString = hiddenMaintenanceCalories.Value;
            if (!string.IsNullOrEmpty(maintenanceCaloriesString))
            {
                SaveIntoHealthyValue();
            }
            else
            {
                lblMessage.Text = "Please calculate the calories first.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

    }
}