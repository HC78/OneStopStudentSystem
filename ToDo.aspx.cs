using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace fyp
{
    public partial class ToDo : System.Web.UI.Page
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
            CheckTasksForCategory(1, noTasksMessage1);
            CheckTasksForCategory(2, noTasksMessage2);
            CheckTasksForCategory(3, noTasksMessage3);
            CheckTasksForCategory(4, noTasksMessage4);

            if (!IsPostBack)
            {
                GridView7.DataBind();
                GridView8.DataBind();
                GridView9.DataBind();
                GridView10.DataBind();
            }
        }

        protected void addBtn1_Click(object sender, EventArgs e)
        {

            if (AddTaskToDatabase(myInput1.Text, 1))
            {
                GridView7.DataBind();
                myInput1.Text = "";
                CheckTasksForCategory(1, noTasksMessage1);
            }
        }

        protected void addBtn2_Click(object sender, EventArgs e)
        {
            if (AddTaskToDatabase(myInput2.Text, 2))
            {
                GridView8.DataBind();
                myInput2.Text = "";
                CheckTasksForCategory(2, noTasksMessage2);
            }
        }

        protected void addBtn3_Click(object sender, EventArgs e)
        {
            if (AddTaskToDatabase(myInput3.Text, 3))
            {
                GridView9.DataBind();
                myInput3.Text = "";
                CheckTasksForCategory(3, noTasksMessage3);
            }
        }

        protected void addBtn4_Click(object sender, EventArgs e)
        {
            if (AddTaskToDatabase(myInput4.Text, 4))
            {
                GridView10.DataBind();
                myInput4.Text = "";
                CheckTasksForCategory(4, noTasksMessage4);
            }
        }


        private bool AddTaskToDatabase(string taskContent, int category)
        {
            if (string.IsNullOrWhiteSpace(taskContent))
            {
                string alertMessage = "Please write something.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}'); window.location.href='ToDo.aspx';", true);
                return false;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();
            string newToDoID = GenerateNextID();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO ToDoList (ToDoID, ToDoContent, studentID, Category) VALUES (@ToDoID, @ToDoContent, @studentID, @Category)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ToDoID", newToDoID);
                        command.Parameters.AddWithValue("@ToDoContent", taskContent);
                        command.Parameters.AddWithValue("@studentID", studentID);
                        command.Parameters.AddWithValue("@Category", category);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
                return false;
            }
        }

        private string GenerateNextID()
        {
            string newID = "TD001";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT TOP 1 ToDoID FROM ToDoList ORDER BY ToDoID DESC", conn);
                    var result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        string lastID = result.ToString();
                        int num = int.Parse(lastID.Substring(2)) + 1;
                        newID = "TD" + num.ToString("D3");
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
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM ToDoList WHERE Category = @Category AND studentID = @studentID", conn);
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

        private void UpdateToDoContent(string toDoID, string newContent)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE ToDoList SET ToDoContent = @ToDoContent WHERE ToDoID = @ToDoID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ToDoID", toDoID);
                        command.Parameters.AddWithValue("@ToDoContent", newContent);

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
                    string query = "DELETE FROM ToDoList WHERE ToDoID = @ToDoID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ToDoID", toDoID);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }

                CheckTasksForCategory(1, noTasksMessage1); 
                CheckTasksForCategory(2, noTasksMessage2);
                CheckTasksForCategory(3, noTasksMessage3); 
                CheckTasksForCategory(4, noTasksMessage4);
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while deleting task: " + ex.Message);
            }
        }

        protected void chkComplete_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkComplete = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkComplete.NamingContainer;
            string toDoID = GridView7.DataKeys[row.RowIndex].Value.ToString();
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
                    string query = "UPDATE ToDoList SET IsCompleted = @IsCompleted WHERE ToDoID = @ToDoID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ToDoID", toDoID);
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
        protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkComplete = (CheckBox)e.Row.FindControl("chkComplete");
                bool isCompleted = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "IsCompleted"));

                chkComplete.Checked = isCompleted;
                e.Row.Style["text-decoration"] = isCompleted ? "line-through" : "none";
            }
        }

    }
}
