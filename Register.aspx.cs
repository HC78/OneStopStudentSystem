using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net.Mail;
using System.Reflection;
using System.Security.AccessControl;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace OneStopStudentSystem
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:initialize(); ", true);
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // First, check if the page is valid
            if (Page.IsValid)
            {
                string emailAddress = txtEmail.Text;
                string username = txtUsername.Text;
                string mobileNumber = txtPhone.Text;
                string errorMessage = "";

                // Check if the username is unique
                if (!IsUsernameUnique(username))
                {
                    errorMessage += "*Username already exists. Please choose a different username.<br/>";
                }

                // Check if the email is unique
                if (!IsEmailUnique(emailAddress))
                {
                    errorMessage += "*Email already exists. Please choose a different email.<br/>";
                }

                // Check if the mobile number is unique
                if (!IsPhoneUnique(mobileNumber))
                {
                    errorMessage += "*Mobile number already exists. Please choose a different mobile number.<br/>";
                }

                // If there are any errors, display them and return early
                if (!string.IsNullOrEmpty(errorMessage))
                {
                    lblError.Text = errorMessage;
                    return;
                }

                insertIntoDatabase();
            }
            else
            {
                lblError.Text = "Please correct the validation errors.";
            }
        }

        private void insertIntoDatabase()
        {
            string fullName = txtName.Text;
            string mobileNumber = txtPhone.Text;
            string emailAddress = txtEmail.Text;
            string username = txtUsername.Text;
            string password = txtPsw.Text;
            string dateOfBirth = txtCal.Text;
            string gender = rblGender.SelectedValue;
            string state = ddlState0.SelectedValue;
            string studentImage = "";
            if (gender == "Male")
            {
                studentImage = "boyProfile.jpg";
            }
            else
            {
                studentImage = "girlProfile.jfif";
            }

            string userID = GetNextUserId();
            string studentID = GenerateNextStudentID();

            SaveIntoStudent(studentID, username, password, fullName, mobileNumber, emailAddress, dateOfBirth, gender, state, studentImage);
            SaveIntoUser(userID, studentID, "Student");

            Response.Redirect("Login.aspx");

        }

        protected void SaveIntoStudent(string studentID, string username, string password, string fullName, string mobileNumber, string emailAddress, string dateOfBirth, string gender, string state, string studentImage)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO student (studentID, studentUsername, studentPassword, studentName, studentMobileNo, studentEmail, studentDOB, studentGender, studentState, studentImage, FailedLoginAttempts, IsAccountLocked) " +
                 "VALUES (@userID, @username, @password, @FullName, @MobileNumber, @EmailAddress, @DateOfBirth, @Gender, @State, @Image, @LA, @locked)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@userID", studentID);
                    command.Parameters.AddWithValue("@username", username);
                    command.Parameters.AddWithValue("@password", password);
                    command.Parameters.AddWithValue("@FullName", fullName);
                    command.Parameters.AddWithValue("@MobileNumber", mobileNumber);
                    command.Parameters.AddWithValue("@EmailAddress", emailAddress);
                    command.Parameters.AddWithValue("@DateOfBirth", dateOfBirth);
                    command.Parameters.AddWithValue("@Gender", gender);
                    command.Parameters.AddWithValue("@State", state);
                    command.Parameters.AddWithValue("@Image", studentImage);
                    command.Parameters.AddWithValue("@LA", 0);
                    command.Parameters.AddWithValue("@locked", 0);
                    connection.Open();
                    command.ExecuteNonQuery();
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

        private bool IsEmailUnique(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM TempUser WHERE tempUserEmail = @email";
            string queryStudent = "SELECT COUNT(*) FROM Student WHERE studentEmail = @email";
            string queryAdmin = "SELECT COUNT(*) FROM Admin WHERE adminEmail = @email";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@email", email);
                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    if (count > 0)
                        return false;
                }

                using (SqlCommand command = new SqlCommand(queryStudent, connection))
                {
                    command.Parameters.AddWithValue("@email", email);
                    int count = (int)command.ExecuteScalar();
                    if (count > 0)
                        return false;
                }

                using (SqlCommand command = new SqlCommand(queryAdmin, connection))
                {
                    command.Parameters.AddWithValue("@email", email);
                    int count = (int)command.ExecuteScalar();
                    if (count > 0)
                        return false;
                }
            }

            return true;
        }

        private bool IsPhoneUnique(string mobile)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM TempUser WHERE tempUserMobileNo = @mobile";
            string queryStudent = "SELECT COUNT(*) FROM Student WHERE studentMobileNo = @mobile";
            string queryAdmin = "SELECT COUNT(*) FROM Admin WHERE adminMobileNo = @mobile";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@mobile", mobile);
                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    if (count > 0)
                        return false;
                }

                using (SqlCommand command = new SqlCommand(queryStudent, connection))
                {
                    command.Parameters.AddWithValue("@mobile", mobile);
                    int count = (int)command.ExecuteScalar();
                    if (count > 0)
                        return false;
                }

                using (SqlCommand command = new SqlCommand(queryAdmin, connection))
                {
                    command.Parameters.AddWithValue("@mobile", mobile);
                    int count = (int)command.ExecuteScalar();
                    if (count > 0)
                        return false;
                }
            }

            return true;
        }

        private bool IsUsernameUnique(string username)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM TempUser WHERE tempUserUsername = @username";
            string queryStudent = "SELECT COUNT(*) FROM Student WHERE studentUsername = @username";
            string queryAdmin = "SELECT COUNT(*) FROM Admin WHERE adminUsername = @username";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", username);
                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    if (count > 0)
                        return false;
                }

                using (SqlCommand command = new SqlCommand(queryStudent, connection))
                {
                    command.Parameters.AddWithValue("@username", username);
                    int count = (int)command.ExecuteScalar();
                    if (count > 0)
                        return false;
                }

                using (SqlCommand command = new SqlCommand(queryAdmin, connection))
                {
                    command.Parameters.AddWithValue("@username", username);
                    int count = (int)command.ExecuteScalar();
                    if (count > 0)
                        return false;
                }
            }

            return true;
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


        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            // txtCal.Text = Calendar1.SelectedDate.ToShortDateString();
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("tnc.aspx");
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("privacyPolicy.aspx");
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtPhone_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {

        }
        protected void txtRePsw_TextChanged(object sender, EventArgs e)
        {

        }

        protected void CheckBoxRequired_ServerValidate(object sender, ServerValidateEventArgs e)
        {
            e.IsValid = cbterms.Checked;
        }

        protected void customValidatorAge_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!string.IsNullOrEmpty(txtCal.Text))
            {
                DateTime selectedDate;
                if (DateTime.TryParse(txtCal.Text, out selectedDate))
                {
                    TimeSpan ageDifference = DateTime.Now - selectedDate;
                    int age = (int)(ageDifference.Days / 365.25);

                    args.IsValid = (age >= 18);
                }
                else
                {
                    args.IsValid = false;
                }
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtName.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtPsw.Text = string.Empty;
            txtRePsw.Text = string.Empty;
            txtCal.Text = string.Empty;
            rblGender.ClearSelection();
            ddlState0.ClearSelection();
            ddlState0.Items.FindByText("<--Select State-->").Selected = true;
            cbterms.Checked = false;
            lblError.Text = string.Empty;

            foreach (BaseValidator validator in Page.Validators)
            {
                validator.IsValid = true;
                validator.Visible = false;
            }

            ValidationSummary1.Visible = false;

            RegularExpressionValidator1.ErrorMessage = string.Empty;
            RegularExpressionValidator2.ErrorMessage = string.Empty;
            CompareValidator1.ErrorMessage = string.Empty;
            customValidatorAge.ErrorMessage = string.Empty;
            CheckBoxRequired.ErrorMessage = string.Empty;

            ValidationSummary1.HeaderText = string.Empty;
            ValidationSummary1.ShowMessageBox = false;
            ValidationSummary1.ShowSummary = false;
        }

        protected void txtPsw_TextChanged(object sender, EventArgs e)
        {

        }

        private bool IsPasswordValid(string password, out string errorMessage)
        {
            var errors = new List<string>();
            if (password.Length < 8)
                errors.Add("Minimum of 8 characters");
            if (!password.Any(char.IsUpper))
                errors.Add("At least 1 upper case character");
            if (!password.Any(char.IsLower))
                errors.Add("At least 1 lower case character");
            if (!password.Any(char.IsDigit))
                errors.Add("At least 1 number character");
            if (!password.Any(ch => !char.IsLetterOrDigit(ch)))
                errors.Add("At least 1 special character");

            if (errors.Any())
            {
                errorMessage = string.Join(", ", errors);
                return false;
            }

            errorMessage = string.Empty;
            return true;
        }

        protected void ValidatePassword(object source, ServerValidateEventArgs args)
        {
            string password = args.Value;
            string errorMessage;
            args.IsValid = IsPasswordValid(password, out errorMessage);
            if (!args.IsValid)
            {
                RegularExpressionValidator1.ErrorMessage = errorMessage;
            }
        }
    }
}