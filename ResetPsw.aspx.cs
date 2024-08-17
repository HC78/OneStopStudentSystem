using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace fyp
{
    public partial class ResetPsw : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                string alertMessage = "Please login first.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}'); window.location.href='Login.aspx';", true);
                return;
            }
        }

        protected void txtPsw_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtConfirmPsw_TextChanged(object sender, EventArgs e)
        {

        }


        private bool UpdatePasswordInDatabase(string username, string newPassword, string oldPsw)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string selectQuery = "";
                string updateQuery = "";
                string userType = Session["userType"] as string;

                if (userType == "Student")
                {
                    selectQuery = "SELECT studentPassword FROM Student WHERE studentUsername = @Username";
                    updateQuery = "UPDATE Student SET studentPassword = @NewPassword WHERE studentUsername = @Username";
                }
                else if (userType == "Admin")
                {
                    selectQuery = "SELECT adminPassword FROM Admin WHERE adminUsername = @Username";
                    updateQuery = "UPDATE Admin SET adminPassword = @NewPassword WHERE adminUsername = @Username";
                }
                else if (userType == "TempUser")
                {
                    selectQuery = "SELECT tempUserPassword FROM TempUser WHERE tempUserUsername = @Username";
                    updateQuery = "UPDATE TempUser SET tempUserPassword = @NewPassword WHERE tempUserUsername = @Username";
                }

                if (string.IsNullOrEmpty(selectQuery) || string.IsNullOrEmpty(updateQuery))
                {
                    lblError.Text = "Invalid user type.";
                    return false;
                }

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Check if old password matches
                    using (SqlCommand selectCommand = new SqlCommand(selectQuery, connection))
                    {
                        selectCommand.Parameters.AddWithValue("@Username", username);

                        string currentPassword = selectCommand.ExecuteScalar() as string;

                        if (currentPassword == null || currentPassword != oldPsw)
                        {
                            lblError.Text = "Old password does not match.";
                            return false;
                        }
                    }

                    // Update to new password
                    using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
                    {
                        updateCommand.Parameters.AddWithValue("@NewPassword", newPassword);
                        updateCommand.Parameters.AddWithValue("@Username", username);

                        int rowsAffected = updateCommand.ExecuteNonQuery();

                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = $"Error: {ex.Message}";
                return false;
            }
        }


        protected void BtnReset_Click(object sender, EventArgs e)
        {
            List<string> errorMessages = new List<string>();
            string newPassword = txtPsw.Text.Trim();
            string confirmPassword = txtConfirmPsw.Text.Trim();
            string oldPsw = txtOldPsw.Text.Trim();
            string username = Session["Username"] as string;
            lblError.Text = "";

            if (string.IsNullOrEmpty(username))
            {
                errorMessages.Add("Username not found in session.");
            }
            if (newPassword != confirmPassword)
            {
                errorMessages.Add("Passwords do not match.");
            }
            if (newPassword == oldPsw)
            {
                errorMessages.Add("New Password Same with Old Password.");
            }

            if (errorMessages.Any())
            {
                lblError.Text = string.Join("<br />", errorMessages);
                return;
            }

            if (UpdatePasswordInDatabase(username, newPassword,oldPsw))
            {
                lblError.Text = "Password reset successfully!";
            }
            else
            {
                lblError.Text = "Old password does not match. Please try again.";
            }
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            txtConfirmPsw.Text = "";
            txtPsw.Text = "";
            lblError.Text = "";
            txtOldPsw.Text = "";
        }
    }
}