using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OneStopStudentSystem
{
    public partial class ToDoE : System.Web.UI.Page 
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
          //  CheckTasksForCategory(1, noTasksMessage1);
          //  CheckTasksForCategory(2, noTasksMessage2);
           // CheckTasksForCategory(3, noTasksMessage3);
         //   CheckTasksForCategory(4, noTasksMessage4);

            if (!IsPostBack)
            {
                GridView7.DataBind();
                GridView8.DataBind();
                GridView9.DataBind();
                GridView10.DataBind();
                GridView11.DataBind();
                GridView12.DataBind();
                GridView13.DataBind();
                GridView14.DataBind();
                GridView15.DataBind();
                GridView16.DataBind();
                GridView17.DataBind();
                GridView18.DataBind();
                GridView19.DataBind();
                GridView20.DataBind();
                GridView1.DataBind();
                GridView2.DataBind();
                GridView3.DataBind();
                GridView4.DataBind();
                GridView5.DataBind();
                GridView6.DataBind();

            }
        }
  
        private void LoadTasks()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT TaskDescription, Importance, Urgency FROM Tasks WHERE studentID = @studentID";
               
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    cmd.Parameters.AddWithValue("@studentID", studentID);
                    SqlDataReader reader = cmd.ExecuteReader();

                    conn.Close();
                }
            }
        }


        protected string GetColor(string importance, string urgency)
        {
            if (importance == "Important" && urgency == "Urgent")
                return "red";
            if (importance == "Important")
                return "orange";
            if (urgency == "Urgent")
                return "yellow";

            return "green";
        }

        protected void btnAddTask_Click(object sender, EventArgs e)
        {
            string taskDescription = txtTask.Text.Trim();
            string importance = ddlImportance.SelectedValue;
            string urgency = ddlUrgency.SelectedValue;

            if (!string.IsNullOrEmpty(taskDescription) && !string.IsNullOrEmpty(importance) && !string.IsNullOrEmpty(urgency))
            {
                AddTaskToDatabase(taskDescription, importance, urgency);

                txtTask.Text = "";
                ddlImportance.SelectedIndex = 0;
                ddlUrgency.SelectedIndex = 0;
                LoadTasks();
            }
            else
            {
                lblMessage.Text = "Please complete all field";
            }
        }

        private void AddTaskToDatabase(string taskDescription, string importance, string urgency)
        {
            if (string.IsNullOrEmpty(taskDescription) || string.IsNullOrEmpty(importance) || string.IsNullOrEmpty(urgency))
            {
                string alertMessage = "Please fill in all required fields.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}');", true);
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            if (Session["UserID"] == null)
            {
                string alertMessage = "Session expired. Please log in again.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}'); window.location.href='Login.aspx';", true);
                return;
            }

            string studentID = Session["UserID"].ToString();
            string newTaskID = GenerateNextID();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Tasks (TaskID, TaskDescription, Importance, Urgency, studentID) VALUES (@TaskID, @TaskDescription, @Importance, @Urgency, @studentID)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TaskID", newTaskID);
                    cmd.Parameters.AddWithValue("@TaskDescription", taskDescription);
                    cmd.Parameters.AddWithValue("@Importance", importance);
                    cmd.Parameters.AddWithValue("@Urgency", urgency);
                    cmd.Parameters.AddWithValue("@studentID", studentID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            GridView7.DataBind();
            GridView8.DataBind();
            GridView9.DataBind();
            GridView10.DataBind();
        }
     
        private string GenerateNextID()
        {
            string newID = "TK001";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT TOP 1 TaskID FROM Tasks ORDER BY TaskID DESC", conn);
                    var result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        string lastID = result.ToString();
                        int num = int.Parse(lastID.Substring(2)) + 1;
                        newID = "TK" + num.ToString("D3");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while generating new ID: " + ex.Message);
            }

            return newID;
        }

        private void CheckTasksForCategory(int category, Label label)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Tasks WHERE Category = @Category AND studentID = @studentID", conn);
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@studentID", studentID);

                    int taskCount = (int)cmd.ExecuteScalar();
                    label.Visible = (taskCount == 0);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while checking tasks: " + ex.Message);
            }
        }

        protected void GridView7_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void GridView7_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView7.EditIndex = e.NewEditIndex;
            GridView7.DataBind();
        }
        protected void GridView8_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView8.EditIndex = e.NewEditIndex;
            GridView8.DataBind();
        }
        protected void GridView9_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView9.EditIndex = e.NewEditIndex;
            GridView9.DataBind();
        }
        protected void GridView10_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView10.EditIndex = e.NewEditIndex;
            GridView10.DataBind();
        }

        protected void GridView7_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView7.Rows[e.RowIndex];
            string toDoID = GridView7.DataKeys[e.RowIndex].Value.ToString();
            string newContent = (row.FindControl("TextBox1") as TextBox).Text;

            UpdateToDoContent(toDoID, newContent);

            GridView7.EditIndex = -1;
            GridView7.DataBind();
        }

        protected void GridView8_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView8.Rows[e.RowIndex];
            string toDoID = GridView8.DataKeys[e.RowIndex].Value.ToString();
            string newContent = (row.FindControl("TextBox2") as TextBox).Text;

            UpdateToDoContent(toDoID, newContent);

            GridView8.EditIndex = -1;
            GridView8.DataBind();
        }

        protected void GridView9_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView9.Rows[e.RowIndex];
            string toDoID = GridView9.DataKeys[e.RowIndex].Value.ToString();
            string newContent = (row.FindControl("TextBox3") as TextBox).Text;

            UpdateToDoContent(toDoID, newContent);

            GridView9.EditIndex = -1;
            GridView9.DataBind();
        }

        protected void GridView10_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView10.Rows[e.RowIndex];
            string toDoID = GridView10.DataKeys[e.RowIndex].Value.ToString();
            string newContent = (row.FindControl("TextBox4") as TextBox).Text;

            UpdateToDoContent(toDoID, newContent);

            GridView10.EditIndex = -1;
            GridView10.DataBind();
        }


        protected void GridView7_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView7.EditIndex = -1;
            GridView7.DataBind();
        }
        protected void GridView8_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView8.EditIndex = -1;
            GridView8.DataBind();
        }
        protected void GridView9_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView9.EditIndex = -1;
            GridView9.DataBind();
        }

        protected void GridView10_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView10.EditIndex = -1;
            GridView10.DataBind();
        }

        private void UpdateToDoContent(string TaskID, string newContent)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Tasks SET TaskDescription = @TaskDescription WHERE TaskID = @TaskID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@TaskID", TaskID);
                        command.Parameters.AddWithValue("@TaskDescription", newContent);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while updating ToDo content: " + ex.Message);
            }
        }

        protected void GridView7_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridView gridView = (GridView)sender;
            int category = Convert.ToInt32(gridView.Attributes["Category"]);

            string toDoID = gridView.DataKeys[e.RowIndex].Value.ToString();
            DeleteTask(toDoID);

            GridView7.DataBind();

        }
        protected void GridView8_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridView gridView = (GridView)sender;
            int category = Convert.ToInt32(gridView.Attributes["Category"]);

            string toDoID = gridView.DataKeys[e.RowIndex].Value.ToString();
            DeleteTask(toDoID);

            GridView8.DataBind();
        }

        protected void GridView9_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridView gridView = (GridView)sender;
            int category = Convert.ToInt32(gridView.Attributes["Category"]);

            string toDoID = gridView.DataKeys[e.RowIndex].Value.ToString();
            DeleteTask(toDoID);

            GridView9.DataBind();
        }

        protected void GridView10_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridView gridView = (GridView)sender;
            int category = Convert.ToInt32(gridView.Attributes["Category"]);

            string toDoID = gridView.DataKeys[e.RowIndex].Value.ToString();
            DeleteTask(toDoID);

            GridView10.DataBind();
        }

        private void DeleteTask(string toDoID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Tasks WHERE TaskID = @TaskID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@TaskID", toDoID);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }

            //    CheckTasksForCategory(1, noTasksMessage1); 
             //   CheckTasksForCategory(2, noTasksMessage2);
              //  CheckTasksForCategory(3, noTasksMessage3); 
              //  CheckTasksForCategory(4, noTasksMessage4);
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while deleting task: " + ex.Message);
            }
        }

        protected void chkComplete7_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkComplete = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkComplete.NamingContainer;
            string toDoID = GridView7.DataKeys[row.RowIndex].Value.ToString();
            bool isCompleted = chkComplete.Checked;

            UpdateTaskCompletionStatus(toDoID, isCompleted);

            row.Style["text-decoration"] = isCompleted ? "line-through" : "none";
        }

        protected void chkComplete8_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkComplete = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkComplete.NamingContainer;
            string toDoID = GridView8.DataKeys[row.RowIndex].Value.ToString();
            bool isCompleted = chkComplete.Checked;

            UpdateTaskCompletionStatus(toDoID, isCompleted);

            row.Style["text-decoration"] = isCompleted ? "line-through" : "none";
        }

        protected void chkComplete9_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkComplete = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkComplete.NamingContainer;
            string toDoID = GridView9.DataKeys[row.RowIndex].Value.ToString();
            bool isCompleted = chkComplete.Checked;

            UpdateTaskCompletionStatus(toDoID, isCompleted);

            row.Style["text-decoration"] = isCompleted ? "line-through" : "none";
        }

        protected void chkComplete10_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkComplete = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkComplete.NamingContainer;
            string toDoID = GridView10.DataKeys[row.RowIndex].Value.ToString();
            bool isCompleted = chkComplete.Checked;

            UpdateTaskCompletionStatus(toDoID, isCompleted);

            row.Style["text-decoration"] = isCompleted ? "line-through" : "none";
        }
        private void UpdateTaskCompletionStatus(string toDoID, bool isCompleted)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Tasks SET IsCompleted = @IsCompleted WHERE TaskID = @TaskID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@TaskID", toDoID);
                        command.Parameters.AddWithValue("@IsCompleted", isCompleted);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while updating task completion status: " + ex.Message);
            }
        }

    
        protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkComplete = (CheckBox)e.Row.FindControl("chkComplete");

                // Ensure chkComplete is not null
                if (chkComplete != null)
                {
                    // Check if DataItem is not null
                    if (e.Row.DataItem != null)
                    {
                        var isCompletedObj = DataBinder.Eval(e.Row.DataItem, "IsCompleted");
                        bool isCompleted = isCompletedObj != null && Convert.ToBoolean(isCompletedObj);

                        chkComplete.Checked = isCompleted;
                        e.Row.Style["text-decoration"] = isCompleted ? "line-through" : "none";
                    }
                }
            }
        }

        protected void GridView8_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkComplete = (CheckBox)e.Row.FindControl("chkComplete");

                // Ensure chkComplete is not null
                if (chkComplete != null)
                {
                    // Check if DataItem is not null
                    if (e.Row.DataItem != null)
                    {
                        var isCompletedObj = DataBinder.Eval(e.Row.DataItem, "IsCompleted");
                        bool isCompleted = isCompletedObj != null && Convert.ToBoolean(isCompletedObj);

                        chkComplete.Checked = isCompleted;
                        e.Row.Style["text-decoration"] = isCompleted ? "line-through" : "none";
                    }
                }
            }
        }

        protected void GridView9_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkComplete = (CheckBox)e.Row.FindControl("chkComplete");

                // Ensure chkComplete is not null
                if (chkComplete != null)
                {
                    // Check if DataItem is not null
                    if (e.Row.DataItem != null)
                    {
                        var isCompletedObj = DataBinder.Eval(e.Row.DataItem, "IsCompleted");
                        bool isCompleted = isCompletedObj != null && Convert.ToBoolean(isCompletedObj);

                        chkComplete.Checked = isCompleted;
                        e.Row.Style["text-decoration"] = isCompleted ? "line-through" : "none";
                    }
                }
            }
        }

        protected void GridView10_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkComplete = (CheckBox)e.Row.FindControl("chkComplete");

                // Ensure chkComplete is not null
                if (chkComplete != null)
                {
                    // Check if DataItem is not null
                    if (e.Row.DataItem != null)
                    {
                        var isCompletedObj = DataBinder.Eval(e.Row.DataItem, "IsCompleted");
                        bool isCompleted = isCompletedObj != null && Convert.ToBoolean(isCompletedObj);

                        chkComplete.Checked = isCompleted;
                        e.Row.Style["text-decoration"] = isCompleted ? "line-through" : "none";
                    }
                }
            }
        }

        protected void GridView7_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }

        protected void ddlSearchImp_SelectedIndexChanged1(object sender, EventArgs e)
        {
            UpdateGridViewData();
        }

        protected void ddlSearchUrgency_SelectedIndexChanged1(object sender, EventArgs e)
        {
            UpdateGridViewData();
        }
        protected void chkNotCompleted_CheckedChanged(object sender, EventArgs e)
        {
            UpdateGridViewData();
        }
        private void UpdateGridViewData()
        {
            // Get selected values from dropdown lists
            string selectedImp = ddlSearchImp.SelectedValue;
            string selectedUrg = ddlSearchUrgency.SelectedValue;
            if (chkNotCompleted.Checked)
            {
                bool showGridView1 = selectedImp == "Important" && string.IsNullOrEmpty(selectedUrg);
                bool showGridView2 = selectedImp == "NotImportant" && string.IsNullOrEmpty(selectedUrg);
                bool showGridView3 = string.IsNullOrEmpty(selectedImp) && selectedUrg == "Urgent";
                bool showGridView4 = string.IsNullOrEmpty(selectedImp) && selectedUrg == "NotUrgent";
                bool showGridView5 = selectedImp == "Important" && selectedUrg == "Urgent";
                bool showGridView6 = selectedImp == "NotImportant" && selectedUrg == "Urgent";
                bool showGridView19 = selectedImp == "Important" && selectedUrg == "NotUrgent";
                bool showGridView20 = selectedImp == "NotImportant" && selectedUrg == "NotUrgent";

                GridView1.Visible = false;
                GridView2.Visible = false;
                GridView3.Visible = false;
                GridView4.Visible = false;
                GridView5.Visible = false;
                GridView6.Visible = false;
                GridView19.Visible = false;
                GridView20.Visible = false;
                GridView11.Visible = false;
                GridView12.Visible = false;
                GridView13.Visible = false;
                GridView14.Visible = false;
                GridView15.Visible = false;
                GridView16.Visible = false;
                GridView17.Visible = false;
                GridView18.Visible = false;
                // Set GridView visibility
                GridView1.Visible = showGridView1;
                GridView2.Visible = showGridView2;
                GridView3.Visible = showGridView3;
                GridView4.Visible = showGridView4;
                GridView5.Visible = showGridView5;
                GridView6.Visible = showGridView6;
                GridView19.Visible = showGridView19;
                GridView20.Visible = showGridView20;

                // Data bind GridViews to update content
                if (GridView1.Visible)
                {
                    GridView1.DataBind();
                    GridView2.Visible = false;
                    GridView3.Visible = false;
                    GridView4.Visible = false;
                    GridView5.Visible = false;
                    GridView6.Visible = false;
                    GridView19.Visible = false;
                    GridView20.Visible = false;
                }
                if (GridView2.Visible)
                {
                    GridView2.DataBind();
                    GridView1.Visible = false;
                    GridView3.Visible = false;
                    GridView4.Visible = false;
                    GridView5.Visible = false;
                    GridView6.Visible = false;
                    GridView19.Visible = false;
                    GridView20.Visible = false;
                }
                if (GridView3.Visible)
                {
                    GridView3.DataBind();
                    GridView2.Visible = false;
                    GridView1.Visible = false;
                    GridView4.Visible = false;
                    GridView5.Visible = false;
                    GridView6.Visible = false;
                    GridView19.Visible = false;
                    GridView20.Visible = false;
                }
                if (GridView4.Visible)
                {
                    GridView4.DataBind();
                    GridView2.Visible = false;
                    GridView3.Visible = false;
                    GridView1.Visible = false;
                    GridView5.Visible = false;
                    GridView6.Visible = false;
                    GridView19.Visible = false;
                    GridView20.Visible = false;
                }
                if (GridView5.Visible)
                {
                    GridView5.DataBind();
                    GridView2.Visible = false;
                    GridView3.Visible = false;
                    GridView4.Visible = false;
                    GridView1.Visible = false;
                    GridView6.Visible = false;
                    GridView19.Visible = false;
                    GridView20.Visible = false;
                }
                if (GridView6.Visible)
                {
                    GridView6.DataBind();
                    GridView2.Visible = false;
                    GridView3.Visible = false;
                    GridView4.Visible = false;
                    GridView5.Visible = false;
                    GridView1.Visible = false;
                    GridView19.Visible = false;
                    GridView20.Visible = false;
                }
                if (GridView19.Visible)
                {
                    GridView19.DataBind();
                    GridView2.Visible = false;
                    GridView3.Visible = false;
                    GridView4.Visible = false;
                    GridView5.Visible = false;
                    GridView6.Visible = false;
                    GridView1.Visible = false;
                    GridView20.Visible = false;
                }
                if (GridView20.Visible)
                {
                    GridView20.DataBind();
                    GridView2.Visible = false;
                    GridView3.Visible = false;
                    GridView4.Visible = false;
                    GridView5.Visible = false;
                    GridView6.Visible = false;
                    GridView19.Visible = false;
                    GridView1.Visible = false;
                }

            }
            else
            {
                // Update GridView visibility based on the selected values
                bool showGridView11 = selectedImp == "Important" && string.IsNullOrEmpty(selectedUrg);
                bool showGridView12 = selectedImp == "NotImportant" && string.IsNullOrEmpty(selectedUrg);
                bool showGridView13 = string.IsNullOrEmpty(selectedImp) && selectedUrg == "Urgent";
                bool showGridView14 = string.IsNullOrEmpty(selectedImp) && selectedUrg == "NotUrgent";
                bool showGridView15 = selectedImp == "Important" && selectedUrg == "Urgent";
                bool showGridView16 = selectedImp == "NotImportant" && selectedUrg == "Urgent";
                bool showGridView17 = selectedImp == "Important" && selectedUrg == "NotUrgent";
                bool showGridView18 = selectedImp == "NotImportant" && selectedUrg == "NotUrgent";

                GridView11.Visible = false;
                GridView12.Visible = false;
                GridView13.Visible = false;
                GridView14.Visible = false;
                GridView15.Visible = false;
                GridView16.Visible = false;
                GridView17.Visible = false;
                GridView18.Visible = false;
                GridView1.Visible = false;
                GridView2.Visible = false;
                GridView3.Visible = false;
                GridView4.Visible = false;
                GridView5.Visible = false;
                GridView6.Visible = false;
                GridView19.Visible = false;
                GridView20.Visible = false;
                // Set GridView visibility
                GridView11.Visible = showGridView11;
                GridView12.Visible = showGridView12;
                GridView13.Visible = showGridView13;
                GridView14.Visible = showGridView14;
                GridView15.Visible = showGridView15;
                GridView16.Visible = showGridView16;
                GridView17.Visible = showGridView17;
                GridView18.Visible = showGridView18;

                // Data bind GridViews to update content
                if (GridView11.Visible)
                {
                    GridView11.DataBind();
                    GridView12.Visible = false;
                    GridView13.Visible = false;
                    GridView14.Visible = false;
                    GridView15.Visible = false;
                    GridView16.Visible = false;
                    GridView17.Visible = false;
                    GridView18.Visible = false;
                }
                if (GridView12.Visible)
                {
                    GridView12.DataBind();
                    GridView11.Visible = false;
                    GridView13.Visible = false;
                    GridView14.Visible = false;
                    GridView15.Visible = false;
                    GridView16.Visible = false;
                    GridView17.Visible = false;
                    GridView18.Visible = false;
                }
                if (GridView13.Visible)
                {
                    GridView13.DataBind();
                    GridView12.Visible = false;
                    GridView11.Visible = false;
                    GridView14.Visible = false;
                    GridView15.Visible = false;
                    GridView16.Visible = false;
                    GridView17.Visible = false;
                    GridView18.Visible = false;
                }
                if (GridView14.Visible)
                {
                    GridView14.DataBind();
                    GridView12.Visible = false;
                    GridView13.Visible = false;
                    GridView11.Visible = false;
                    GridView15.Visible = false;
                    GridView16.Visible = false;
                    GridView17.Visible = false;
                    GridView18.Visible = false;
                }
                if (GridView15.Visible)
                {
                    GridView15.DataBind();
                    GridView12.Visible = false;
                    GridView13.Visible = false;
                    GridView14.Visible = false;
                    GridView11.Visible = false;
                    GridView16.Visible = false;
                    GridView17.Visible = false;
                    GridView18.Visible = false;
                }
                if (GridView16.Visible)
                {
                    GridView16.DataBind();
                    GridView12.Visible = false;
                    GridView13.Visible = false;
                    GridView14.Visible = false;
                    GridView15.Visible = false;
                    GridView11.Visible = false;
                    GridView17.Visible = false;
                    GridView18.Visible = false;
                }
                if (GridView17.Visible)
                {
                    GridView17.DataBind();
                    GridView12.Visible = false;
                    GridView13.Visible = false;
                    GridView14.Visible = false;
                    GridView15.Visible = false;
                    GridView16.Visible = false;
                    GridView11.Visible = false;
                    GridView18.Visible = false;
                }
                if (GridView18.Visible)
                {
                    GridView18.DataBind();
                    GridView12.Visible = false;
                    GridView13.Visible = false;
                    GridView14.Visible = false;
                    GridView15.Visible = false;
                    GridView16.Visible = false;
                    GridView17.Visible = false;
                    GridView11.Visible = false;
                }
            }
        }

    }
}
