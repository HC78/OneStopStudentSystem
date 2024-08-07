using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OneStopStudentSystem
{
    public partial class AdminRoleMng : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] == null)
                {
                    string alertMessage = "Please login first.";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}'); window.location.href='Login.aspx';", true);
                    return;
                }
                else if ((string)Session["UserType"] != "Admin")
                {
                    string alertMessage = "Please login as a Admin.";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}'); window.location.href='Login.aspx';", true);
                    return;
                }

                // Bind GridView with data
                BindGridView();
                GridView2.Visible = false;
                GridView4.Visible = false;
                GridView5.Visible = false;
                GridView6.Visible = false;
                GridView7.Visible = false;
            }
        }


        protected void BindGridView()
        {
            GridView1.DataBind();
            GridView2.DataBind();
            GridView4.DataBind();
            GridView5.DataBind();
            GridView6.DataBind();
            GridView7.DataBind();

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            string userID = ddlUserID.SelectedValue;

            string selectedRole = ddlNewRole.SelectedValue;


            // Transfer user to the selected role and update user role and ID
            bool roleAssigned = false;
            switch (selectedRole)
            {
                case "Student":
                    roleAssigned = TransferUserDataToStudent(userID);
                    break;
                case "Admin":
                    roleAssigned = TransferUserDataToAdmin(userID);
                    break;
                default:
                    lblMessage.Text += "Cannot Assign ";
                    break;
            }

            // Refresh GridView
            BindGridView();

            lblMessage.Text += userID + " to " + selectedRole + ".   ";
            // Show message based on role assignment
            if (roleAssigned)
            {
                lblMessage.Text += "Role assigned successfully.";
            }
            else
            {
                lblMessage.Text += "Role assignment failed. Please try again.";
            }

        }


        protected bool TransferUserDataToStudent(string userID)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string newStudentID = GenerateNextStudentID();

                // Query to select tempUserID from UserAccount
                string query1 = "SELECT tempUserID FROM UserAccount WHERE userID=@userID";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query1, connection))
                    {
                        command.Parameters.AddWithValue("@userID", userID);
                        connection.Open();

                        // Execute the query and retrieve the tempUserID
                        object tempUserIDObj = command.ExecuteScalar();
                        if (tempUserIDObj != null)
                        {
                            string tempUserID = tempUserIDObj.ToString(); // Assuming tempUserID is already a string

                            // Query to insert into Student table 
                            string insertQuery = "INSERT INTO Student (studentID, studentUsername, studentPassword, studentName, studentMobileNo, studentEmail, studentDOB, studentGender, studentState, studentImage, FailedLoginAttempts, IsAccountLocked, AccountLockTime)" +
                                                 "SELECT @newStudentID, tempUserUsername, tempUserPassword, tempUserName, tempUserMobileNo, tempUserEmail, tempUserDOB, tempUserGender, tempUserState, tempUserImage, FailedLoginAttempts, IsAccountLocked, AccountLockTime " +
                                                 "FROM TempUser WHERE tempUserID = @tempUserID;";

                            // Execute the insert query with tempUserID parameter
                            using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                            {
                                insertCommand.Parameters.AddWithValue("@newStudentID", newStudentID);
                                insertCommand.Parameters.AddWithValue("@tempUserID", tempUserID);
                                int rowsAffected = insertCommand.ExecuteNonQuery();
                                if (rowsAffected > 0)
                                {
                                    // Update User Account table
                                    UpdateUserAccountTable(userID, "Student", newStudentID);
                                    lblMessage.Text += "Role assigned successfully.";

                                    // Execute the delete query
                                    string deleteQuery = "DELETE FROM TempUser WHERE tempUserID = @tempUserID;";
                                    using (SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection))
                                    {
                                        deleteCommand.Parameters.AddWithValue("@tempUserID", tempUserID);
                                        deleteCommand.ExecuteNonQuery();
                                    }
                                    return true;
                                }
                                else
                                {
                                    lblMessage.Text += "Error: Failed to transfer user to student role. Please try again.";
                                    return false;
                                }
                            }
                        }
                        else
                        {
                            lblMessage.Text += "Error: User does not exist or has already been assigned a role.";
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception details
                LogException(ex);
                lblMessage.Text += $"Error transferring user to student role: {ex.Message}";
                lblMessage.Text += "<br/>";
                lblMessage.Text += " ";
                return false;
            }
        }

        private void LogException(Exception ex)
        {
            Console.WriteLine($"Exception occurred: {ex.Message}");
            Console.WriteLine($"Stack Trace: {ex.StackTrace}");
        }

        protected bool TransferUserDataToAdmin(string userID)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string newAdminID = GenerateNextAdminID();

                // Query to select tempUserID from UserAccount
                string query1 = "SELECT tempUserID FROM UserAccount WHERE userID=@userID";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query1, connection))
                    {
                        command.Parameters.AddWithValue("@userID", userID);
                        connection.Open();

                        // Execute the query and retrieve the tempUserID
                        object tempUserIDObj = command.ExecuteScalar();
                        if (tempUserIDObj != null)
                        {
                            string tempUserID = tempUserIDObj.ToString(); // Assuming tempUserID is already a string

                            // Correct the column names as per the TempUser table
                            string insertQuery = "INSERT INTO Admin (adminId, adminUsername, adminPassword, adminName, adminMobileNo, adminEmail, adminDOB, adminGender, adminState, adminImage, FailedLoginAttempts, IsAccountLocked, AccountLockTime) " +
                                                 "SELECT @newAdminID, tempUserUsername, tempUserPassword, tempUserName, tempUserMobileNo, tempUserEmail, tempUserDOB, tempUserGender, tempUserState, tempUserImage, FailedLoginAttempts, IsAccountLocked, AccountLockTime " +
                                                 "FROM TempUser WHERE tempUserID = @tempUserID;";

                            // Execute the insert query with tempUserID parameter
                            using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                            {
                                insertCommand.Parameters.AddWithValue("@newAdminID", newAdminID);
                                insertCommand.Parameters.AddWithValue("@tempUserID", tempUserID);
                                int rowsAffected = insertCommand.ExecuteNonQuery();
                                if (rowsAffected > 0)
                                {
                                    // Update User Account table
                                    UpdateUserAccountTable(userID, "Admin", newAdminID);
                                    lblMessage.Text += "Role assigned successfully.";

                                    // Execute the delete query
                                    string deleteQuery = "DELETE FROM TempUser WHERE tempUserID = @tempUserID;";
                                    using (SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection))
                                    {
                                        deleteCommand.Parameters.AddWithValue("@tempUserID", tempUserID);
                                        deleteCommand.ExecuteNonQuery();
                                    }
                                    return true;
                                }
                                else
                                {
                                    lblMessage.Text += "Error: Failed to transfer user to admin role. Please try again.";
                                    return false;
                                }
                            }
                        }
                        else
                        {
                            lblMessage.Text += "Error: User does not exist or has already been assigned a role.";
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text += $"Error transferring user to admin role: {ex.Message}";
                return false;
            }
        }



        protected void UpdateUserAccountTable(string userID, string selectedRole, string newRoleID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            string query = "UPDATE UserAccount SET userRole = @selectedRole, " +
                            "studentID = CASE WHEN @selectedRole = 'Student' THEN @newRoleID ELSE NULL END, " +
                           "adminId = CASE WHEN @selectedRole = 'Admin' THEN @newRoleID ELSE NULL END, " +
                           "tempUserID = NULL " +
                           "WHERE userID = @userID;";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@selectedRole", selectedRole);
                    command.Parameters.AddWithValue("@newRoleID", newRoleID);
                    command.Parameters.AddWithValue("@userID", userID);
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

        protected string GenerateNextAdminID()
        {
            string nextUserId = "A0001";

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT MAX(adminID) FROM Admin";

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
                            nextUserId = "A" + (number + 1).ToString().PadLeft(4, '0');
                        }
                    }
                }
            }
            return nextUserId;
        }


        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedRole = DropDownList1.SelectedValue;

            switch (selectedRole)
            {
                case "Admin":
                    if (chkLockedAccounts.Checked)
                    {
                        lblMessage.Text = "There will not have locked admin account.";
                        GridView2.Visible = true;
                        GridView4.Visible = false;
                        GridView5.Visible = false;
                        GridView6.Visible = false;
                        GridView7.Visible = false;
                    }
                    else
                    {
                        lblMessage.Text = "";
                        GridView2.Visible = true;
                        GridView4.Visible = false;
                        GridView5.Visible = false;
                        GridView6.Visible = false;
                        GridView7.Visible = false;
                    }
                    break;

                case "Student":
                    if (chkLockedAccounts.Checked)
                    {
                        lblMessage.Text = "";
                        GridView6.Visible = true;
                        GridView4.Visible = false;
                        GridView2.Visible = false;
                        GridView5.Visible = false;
                        GridView7.Visible = false;
                    }
                    else
                    {
                        lblMessage.Text = "";
                        GridView4.Visible = true;
                        GridView2.Visible = false;
                        GridView5.Visible = false;
                        GridView7.Visible = false;
                        GridView6.Visible = false;
                    }
                    break;

                case "TempUser":
                    if (chkLockedAccounts.Checked)
                    {
                        lblMessage.Text = "";
                        GridView7.Visible = true;
                        GridView6.Visible = false;
                        GridView4.Visible = false;
                        GridView2.Visible = false;
                        GridView5.Visible = false;
                    }
                    else
                    {
                        lblMessage.Text = "";
                        GridView7.Visible = false;
                        GridView4.Visible = false;
                        GridView6.Visible = false;
                        GridView2.Visible = false;
                        GridView5.Visible = true;
                    }
                    break;
                default:

                    break;
            }
        }


        protected void GridView4_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ResetAccount")
            {
                string studentID = e.CommandArgument.ToString();
                ResetAccount("Student", studentID);
            }
        }

        protected void GridView5_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ResetAccount")
            {
                string tempUserID = e.CommandArgument.ToString();
                ResetAccount("TempUser", tempUserID);
            }
        }

        private void ResetAccount(string userType, string userID)
        {
            string tableName = userType == "Student" ? "Student" : "TempUser";
            string idColumnName = userType == "Student" ? "studentID" : "tempUserID";

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = $"UPDATE {tableName} SET FailedLoginAttempts = 0, IsAccountLocked = 0, AccountLockTime = NULL WHERE {idColumnName} = @userID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@userID", userID);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            BindGridView();
        }

        protected void GridView4_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Button resetButton = (Button)e.Row.FindControl("btnResetAccount");
                if (resetButton != null)
                {
                    resetButton.CommandArgument = ((DataRowView)e.Row.DataItem)["studentID"].ToString();
                }
            }
        }

        protected void GridView5_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Button resetButton = (Button)e.Row.FindControl("btnResetAccount");
                if (resetButton != null)
                {
                    resetButton.CommandArgument = ((DataRowView)e.Row.DataItem)["tempUserID"].ToString();
                }
            }
        }

      
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void chkLockedAccounts_CheckedChanged(object sender, EventArgs e)
        {
            string selectedRole = DropDownList1.SelectedValue;

            switch (selectedRole)
            {
                case "Admin":
                    if (chkLockedAccounts.Checked)
                    {
                        lblMessage.Text = "There will not have locked admin account.";
                        GridView2.Visible = true;
                        GridView4.Visible = false;
                        GridView5.Visible = false;
                        GridView6.Visible = false;
                        GridView7.Visible = false;
                    }
                    else
                    {
                        lblMessage.Text = "";
                        GridView2.Visible = true;
                        GridView4.Visible = false;
                        GridView5.Visible = false;
                        GridView6.Visible = false;
                        GridView7.Visible = false;
                    }
                    break;

                case "Student":
                    if (chkLockedAccounts.Checked)
                    {
                        lblMessage.Text = "";
                        GridView6.Visible = true;
                        GridView4.Visible = false;
                        GridView2.Visible = false;
                        GridView5.Visible = false;
                        GridView7.Visible = false;
                    }
                    else
                    {
                        lblMessage.Text = "";
                        GridView4.Visible = true;
                        GridView2.Visible = false;
                        GridView5.Visible = false;
                        GridView7.Visible = false;
                        GridView6.Visible = false;
                    }
                    break;

                case "TempUser":
                    if (chkLockedAccounts.Checked)
                    {
                        lblMessage.Text = "";
                        GridView7.Visible = true;
                        GridView6.Visible = false;
                        GridView4.Visible = false;
                        GridView2.Visible = false;
                        GridView5.Visible = false;
                    }
                    else
                    {
                        lblMessage.Text = "";
                        GridView7.Visible = false;
                        GridView4.Visible = false;
                        GridView6.Visible = false;
                        GridView2.Visible = false;
                        GridView5.Visible = true;
                    }
                    break;
                default:

                    break;
            }
        }
    }
}