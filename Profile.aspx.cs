using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OneStopStudentSystem
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    string username = Session["Username"].ToString();
                    GetUserProfile(username);
                }
                else
                {
                    string alertMessage = "Please login first.";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}'); window.location.href='Login.aspx';", true);
                    return;
                }
            }
        }

        private void GetUserProfile(string username)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT studentName, FORMAT(studentDOB, 'dd/MM/yyyy') AS studentDOB, studentGender, studentState, studentEmail, studentMobileNo, studentImage FROM Student WHERE studentUsername = @Username";
            string query2 = "SELECT adminName, FORMAT(adminDOB, 'dd/MM/yyyy') AS adminDOB, adminGender, adminState, adminEmail, adminMobileNo, adminImage FROM Admin WHERE adminUsername = @Username";
            string query3 = "SELECT tempUserName, FORMAT(tempUserDOB, 'dd/MM/yyyy') AS tempUserDOB, tempUserGender, tempUserState, tempUserEmail, tempUserMobileNo, tempUserImage FROM TempUser WHERE tempUserUsername = @Username";

            boyProfile.Visible = false;
            girlProfile.Visible = false;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        txtName.Text = reader["studentName"].ToString();
                        txtCal0.Text = reader["studentDOB"].ToString();

                        if (rblGender.Items.FindByValue(reader["studentGender"].ToString()) != null)
                        {
                            rblGender.SelectedValue = reader["studentGender"].ToString();
                        }

                        if (ddlState0.Items.FindByValue(reader["studentState"].ToString()) != null)
                        {
                            ddlState0.SelectedValue = reader["studentState"].ToString();
                        }

                        txtEmail.Text = reader["studentEmail"].ToString();
                        txtPhone0.Text = reader["studentMobileNo"].ToString();
                        string imagePath = reader["studentImage"].ToString();

                        if (!string.IsNullOrEmpty(imagePath))
                        {
                            Image1.ImageUrl = "/Image/" + imagePath;
                            Image1.Visible = true;
                            boyProfile.Visible = false;
                            girlProfile.Visible = false;
                        }
                        else
                        {
                            if (reader["studentGender"].ToString() == "Female")
                            {
                                girlProfile.Visible = true;
                                boyProfile.Visible = false;
                                Image1.Visible = false;
                            }
                            else if (reader["studentGender"].ToString() == "Male")
                            {
                                boyProfile.Visible = true;
                                girlProfile.Visible = false;
                                Image1.Visible = false;
                            }
                        }
                    }

                    reader.Close();
                }
                // Check for TempUser profile
                using (SqlCommand command = new SqlCommand(query3, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        txtName.Text = reader["tempUserName"].ToString();
                        txtCal0.Text = reader["tempUserDOB"].ToString();

                        if (rblGender.Items.FindByValue(reader["tempUserGender"].ToString()) != null)
                        {
                            rblGender.SelectedValue = reader["tempUserGender"].ToString();
                        }

                        if (ddlState0.Items.FindByValue(reader["tempUserState"].ToString()) != null)
                        {
                            ddlState0.SelectedValue = reader["tempUserState"].ToString();
                        }

                        ddlState0.SelectedValue = reader["tempUserState"].ToString();
                        txtPhone0.Text = reader["tempUserMobileNo"].ToString();

                        string imagePath = reader["tempUserImage"].ToString();

                        if (!string.IsNullOrEmpty(imagePath))
                        {
                            Image1.ImageUrl = "/Image/" + imagePath;
                            Image1.Visible = true;
                            boyProfile.Visible = false;
                            girlProfile.Visible = false;
                        }
                        else
                        {
                            if (reader["tempUserGender"].ToString() == "Female")
                            {
                                girlProfile.Visible = true;
                                boyProfile.Visible = false;
                                Image1.Visible = false;
                            }
                            else if (reader["tempUserGender"].ToString() == "Male")
                            {
                                boyProfile.Visible = true;
                                girlProfile.Visible = false;
                                Image1.Visible = false;
                            }
                        }
                    }

                    reader.Close();
                }

                // Check for Admin profile
                using (SqlCommand command = new SqlCommand(query2, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        txtName.Text = reader["adminName"].ToString();
                        txtCal0.Text = reader["adminDOB"].ToString();
                 
                        if (rblGender.Items.FindByValue(reader["adminGender"].ToString()) != null)
                        {
                            rblGender.SelectedValue = reader["adminGender"].ToString();
                        }

                        if (ddlState0.Items.FindByValue(reader["adminState"].ToString()) != null)
                        {
                            ddlState0.SelectedValue = reader["adminState"].ToString();
                        }

                        txtEmail.Text = reader["adminEmail"].ToString();
                        txtPhone0.Text = reader["adminMobileNo"].ToString();

                        string imagePath = reader["adminImage"].ToString();

                        if (!string.IsNullOrEmpty(imagePath))
                        {
                            Image1.ImageUrl = "/Image/" + imagePath;
                            Image1.Visible = true;
                            boyProfile.Visible = false;
                            girlProfile.Visible = false;
                        }
                        else
                        {
                            if (reader["adminGender"].ToString() == "Female")
                            {
                                girlProfile.Visible = true;
                                boyProfile.Visible = false;
                                Image1.Visible = false;
                            }
                            else if (reader["adminGender"].ToString() == "Male")
                            {
                                boyProfile.Visible = true;
                                girlProfile.Visible = false; 
                                Image1.Visible = false;
                            }
                        }
                    }

                    reader.Close();
                }
            }
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                string username = Session["Username"].ToString();
                string name = txtName.Text;
                string dob = txtCal0.Text;
                string gender = rblGender.SelectedValue;
                string state = ddlState0.SelectedValue;
                string email = txtEmail.Text;
                string mobileNo = txtPhone0.Text;
                string imagePath = "";

                if (FileUpload1.HasFile)
                {
                    string filename = Path.GetFileName(FileUpload1.FileName);
                    FileUpload1.SaveAs(Server.MapPath("~/Image/") + filename);
                    imagePath = filename;

                    Image1.Visible = true;
                    Image1.ImageUrl = "~/Image/" + filename;
                    boyProfile.Visible = false;
                    girlProfile.Visible = false;
                }
                else
                {
                    imagePath = Image1.ImageUrl.Replace("~/Image/", "");

                    boyProfile.Visible = false;
                    girlProfile.Visible = false;
                }

                UpdateUserProfile(username, name, dob, gender, state, email, mobileNo, imagePath);
                GetUserProfile(username);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        private void UpdateUserProfile(string username, string name, string dob, string gender, string state, string email, string mobileNo, string imagePath)
        {
            DateTime dobDate;
            if (!DateTime.TryParseExact(dob, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dobDate))
            {
                lblMessage.Text="Invalid date format for date of birth.(20/12/2002)";
                lblMessage.Visible = true;
                return;
            }

            TimeSpan ageDifference = DateTime.Now - dobDate;
            int age = (int)(ageDifference.Days / 365.25);
            if (age < 18)
            {
                lblMessage.Text = "Only university students who are 18 years old or older are eligible to register an account.";
                lblMessage.Visible = true; 
                return;
            }

            string phonePattern = @"^01[0-9]-[0-9]{7}$|^01[0-9]-[0-9]{8}$";
            if (!Regex.IsMatch(mobileNo, phonePattern))
            {
                lblMessage.Text = "Invalid phone number format. Please enter correct mobile number 01x-xxxxxxx or 01x-xxxxxxxx";
                lblMessage.Visible = true; 
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "";
            string userType = Session["UserType"].ToString();

            switch (userType)
            {
                case "Student":
                    query = "UPDATE Student SET studentName = @Name, studentDOB = @DOB, studentGender = @Gender, studentState = @State, studentEmail = @Email, studentMobileNo = @MobileNo";
                    if (!string.IsNullOrEmpty(imagePath))
                    {
                        query += ", studentImage = @ProfileImage";
                    }
                    query += " WHERE studentUsername = @Username";
                    break;
                case "Staff":
                    query = "UPDATE Staff SET staffName = @Name, staffDOB = @DOB, staffGender = @Gender, staffState = @State, staffEmail = @Email, staffMobileNo = @MobileNo";
                    if (!string.IsNullOrEmpty(imagePath))
                    {
                        query += ", staffImage = @ProfileImage";
                    }
                    query += " WHERE staffUsername = @Username";
                    break;
                case "Admin":
                    query = "UPDATE Admin SET adminName = @Name, adminDOB = @DOB, adminGender = @Gender, adminState = @State, adminEmail = @Email, adminMobileNo = @MobileNo";
                    if (!string.IsNullOrEmpty(imagePath))
                    {
                        query += ", adminImage = @ProfileImage";
                    }
                    query += " WHERE adminUsername = @Username";
                    break;
                case "TempUser":
                    query = "UPDATE TempUser SET tempUserName = @Name, tempUserDOB = @DOB, tempUserGender = @Gender, tempUserState = @State, tempUserEmail = @Email, tempUserMobileNo = @MobileNo";
                    if (!string.IsNullOrEmpty(imagePath))
                    {
                        query += ", tempUserImage = @ProfileImage";
                    }
                    query += " WHERE tempUserUsername = @Username";
                    break;
                default:
                    Response.Write("Invalid user type.");
                    return;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Name", name);
                    command.Parameters.AddWithValue("@DOB", dobDate);
                    command.Parameters.AddWithValue("@Gender", gender);
                    command.Parameters.AddWithValue("@State", state);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@MobileNo", mobileNo);
                    command.Parameters.AddWithValue("@Username", username);
                    if (!string.IsNullOrEmpty(imagePath))
                    {
                        command.Parameters.AddWithValue("@ProfileImage", imagePath);
                    }

                    try
                    {
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "Profile updated successfully!";
                        }
                        else
                        {
                           lblMessage.Text = "Failed to update profile. Please try again.";
                        }
                    }
                    catch (Exception ex)
                    {
                         lblMessage.Text = "An error occurred: " + ex.Message;
                    }
                }
            }
        }




        protected void TextBox9_TextChanged(object sender, EventArgs e)
        {

        }


        protected void txtName_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtCal0_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtPhone_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlRace_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlProfession_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void rblGender_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}