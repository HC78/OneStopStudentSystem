using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace fyp
{
    public partial class ToDoList : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
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
                LoadTasks();
            }
        }

        protected void LoadTasks()
        {
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            string userId = Session["UserID"].ToString();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM ToDoList WHERE studentID = @studentID", conn);
                cmd.Parameters.AddWithValue("@studentID", userId);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    int category = Convert.ToInt32(reader["Category"]);
                    string taskTitle = reader["ToDoContent"].ToString();
                    string taskId = reader["ToDoID"].ToString();
                    AddTaskToUI(category, taskTitle, taskId);
                }
                reader.Close();
            }
        }

        protected void NewElement_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int category = Convert.ToInt32(btn.CommandArgument);
            string inputId = "myInput" + category;
            TextBox input = (TextBox)FindControl(inputId);
            string taskTitle = input.Text.Trim();

            if (!string.IsNullOrEmpty(taskTitle))
            {
                AddTaskToDB(category, taskTitle);
                input.Text = "";
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Task title cannot be empty.');", true);
            }
        }

        protected void AddTaskToDB(int category, string title)
        {
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();
            string newToDoID = GenerateID();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO ToDoList (ToDoID, ToDoContent, studentID, Category) VALUES (@ToDoID, @ToDoContent, @studentID, @Category);", conn);
                cmd.Parameters.AddWithValue("@ToDoID", newToDoID);
                cmd.Parameters.AddWithValue("@ToDoContent", title);
                cmd.Parameters.AddWithValue("@studentID", studentID);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.ExecuteNonQuery();
            }
            AddTaskToUI(category, title, newToDoID);
        }

        protected void AddTaskToUI(int category, string title, string taskId)
        {
            string ulId = "myUL" + category;
            HtmlGenericControl ul = (HtmlGenericControl)FindControl(ulId);
            HtmlGenericControl li = new HtmlGenericControl("li");
            li.InnerText = title;
            li.Attributes.Add("data-todoid", taskId);
            ul.Controls.Add(li);

            AppendButtons(li, category);
            ToggleNoTasksMessage(category);
        }

        protected void AppendButtons(HtmlGenericControl li, int category)
        {
            HtmlGenericControl closeSpan = new HtmlGenericControl("span");
            closeSpan.Attributes.Add("class", "close");
            closeSpan.InnerText = "🗑️";
            closeSpan.Attributes.Add("onclick", $"deleteTask('{li.Attributes["data-todoid"]}', {category})");
            li.Controls.Add(closeSpan);

            HtmlGenericControl editTaskBtn = new HtmlGenericControl("span");
            editTaskBtn.Attributes.Add("class", "edit-task-btn");
            editTaskBtn.InnerHtml = "&#9998;";
            editTaskBtn.Attributes.Add("onclick", $"editTask('{li.Attributes["data-todoid"]}', '{li.InnerText}')");
            li.Controls.Add(editTaskBtn);
        }

        protected void ToggleNoTasksMessage(int category)
        {
            string noTasksMessageId = "noTasksMessage" + category;
            HtmlGenericControl noTasksMessage = (HtmlGenericControl)FindControl(noTasksMessageId);
            if (noTasksMessage != null)
            {
                noTasksMessage.Style["display"] = "none";

                // Check if there are any visible tasks in the list
                string ulId = "myUL" + category;
                HtmlGenericControl ul = (HtmlGenericControl)FindControl(ulId);
                if (ul != null)
                {
                    bool allTasksHidden = true;
                    foreach (Control control in ul.Controls)
                    {
                        if (control is HtmlGenericControl li && li.Style["display"] != "none")
                        {
                            allTasksHidden = false;
                            break;
                        }
                    }
                    if (allTasksHidden)
                    {
                        noTasksMessage.Style["display"] = "block";
                    }
                }
            }
        }

        public void UpdateTask(string taskId, string newTitle)
        {
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("UPDATE ToDoList SET ToDoContent = @ToDoContent WHERE ToDoID = @ToDoID", conn);
                cmd.Parameters.AddWithValue("@ToDoContent", newTitle);
                cmd.Parameters.AddWithValue("@ToDoID", taskId);
                cmd.ExecuteNonQuery();
            }
        }

        public void DeleteTask(string taskId)
        {
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM ToDoList WHERE ToDoID = @ToDoID", conn);
                cmd.Parameters.AddWithValue("@ToDoID", taskId);
                cmd.ExecuteNonQuery();
            }
        }

        protected override void RaisePostBackEvent(IPostBackEventHandler source, string eventArgument)
        {
            try
            {
                if (string.IsNullOrEmpty(eventArgument))
                {
                    throw new ArgumentException("Invalid or empty eventArgument");
                }

                // Log received eventArgument for debugging
                System.Diagnostics.Debug.WriteLine($"Received eventArgument: {eventArgument}");

                if (eventArgument.StartsWith("AddTask"))
                {
                    string[] args = eventArgument.Split(':');
                    if (args.Length >= 3)
                    {
                        int category = Convert.ToInt32(args[1]);
                        string title = args[2];
                        AddTaskToDB(category, title);
                    }
                    else
                    {
                        throw new ArgumentException("Invalid AddTask eventArgument format");
                    }
                }
                else if (eventArgument.StartsWith("DeleteTask"))
                {
                    string taskId = eventArgument.Split(':')[1];
                    DeleteTask(taskId);
                }
                else if (eventArgument.StartsWith("UpdateTask"))
                {
                    string[] args = eventArgument.Split(':');
                    string taskId = args[1];
                    string newTitle = args[2];
                    UpdateTask(taskId, newTitle);
                }
                else
                {
                    base.RaisePostBackEvent(source, eventArgument);
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error in RaisePostBackEvent: " + ex.Message);
                // Log the exception or take appropriate action
            }
        }





        private string GenerateID()
        {
            string newID = "TD001";
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
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
            return newID;
        }
    }
}
