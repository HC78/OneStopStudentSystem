using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OneStopStudentSystem
{
    public partial class Goal : System.Web.UI.Page
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
            CheckGoal(noGoalMsg);
            if (!IsPostBack)
            {
                GridView7.DataBind();
            }
            GridView7.RowDataBound += GridView7_RowDataBound;
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            if (AddGoalToDatabase(txtGoal.Text, txtReward.Text, txtMilestones.Text, txtQuote.Text))
            {
                GridView7.DataBind();
                txtGoal.Text = "";
                txtReward.Text = "";
                txtMilestones.Text = "";
                txtQuote.Text = "";
                CheckGoal(noGoalMsg);
            }
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            txtGoal.Text = "";
            txtReward.Text = "";
            txtMilestones.Text = "";
            txtQuote.Text = "";
        }

        private void CheckGoal(Label label)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Goal WHERE studentID = @studentID", conn);
                    cmd.Parameters.AddWithValue("@studentID", studentID);

                    int goalCount = (int)cmd.ExecuteScalar();
                    label.Visible = (goalCount == 0);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while checking tasks: " + ex.Message);
            }
        }

        private bool AddGoalToDatabase(string goal, string reward, string milestone, string quote)
        {
            if (string.IsNullOrWhiteSpace(goal))
            {
                string alertMessage = "Please write something.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}');", true);
                return false;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();
            string newGoalID = GenerateNextID();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Goal (GoalID, GoalTitle, GoalReward, GoalMilestone, GoalQuote, studentID) VALUES (@ID, @title, @reward, @milestone, @quote, @studentID)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ID", newGoalID);
                        command.Parameters.AddWithValue("@title", goal);
                        command.Parameters.AddWithValue("@reward", reward);
                        command.Parameters.AddWithValue("@milestone", milestone);
                        command.Parameters.AddWithValue("@quote", quote);
                        command.Parameters.AddWithValue("@studentID", studentID);

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
            string newID = "GN001";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT TOP 1 GoalID FROM Goal ORDER BY GoalID DESC", conn);
                    var result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        string lastID = result.ToString();
                        int num = int.Parse(lastID.Substring(2)) + 1;
                        newID = "GN" + num.ToString("D3");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while generating new ID: " + ex.Message);
            }

            return newID;
        }

        protected void GridView7_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView7.EditIndex = e.NewEditIndex;
            GridView7.DataBind();
        }

        protected void GridView7_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView7.Rows[e.RowIndex];
            string goalID = GridView7.DataKeys[e.RowIndex].Values["GoalID"].ToString();
            string goalTitle = ((TextBox)row.Cells[2].Controls[0]).Text;
            string goalReward = ((TextBox)row.Cells[3].Controls[0]).Text;
            string goalMilestone = ((TextBox)row.Cells[4].Controls[0]).Text;
            string goalQuote = ((TextBox)row.Cells[5].Controls[0]).Text;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Goal SET GoalTitle = @title, GoalReward = @reward, GoalMilestone = @milestone, GoalQuote = @quote WHERE GoalID = @ID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ID", goalID);
                        command.Parameters.AddWithValue("@title", goalTitle);
                        command.Parameters.AddWithValue("@reward", goalReward);
                        command.Parameters.AddWithValue("@milestone", goalMilestone);
                        command.Parameters.AddWithValue("@quote", goalQuote);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                GridView7.EditIndex = -1;
                GridView7.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
            }
        }

        protected void GridView7_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string goalID = GridView7.DataKeys[e.RowIndex].Values["GoalID"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Goal WHERE GoalID = @ID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ID", goalID);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                GridView7.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
            }
        }

        protected void GridView7_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView7.EditIndex = -1;
            GridView7.DataBind();
        }

        protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                object isCompletedValue = DataBinder.Eval(e.Row.DataItem, "IsCompleted");

                bool isCompleted = false; 

                if (isCompletedValue != DBNull.Value && isCompletedValue != null)
                {
                    isCompleted = Convert.ToBoolean(isCompletedValue);
                }

                if (isCompleted)
                {
                    e.Row.Style.Add("text-decoration", "line-through");
                }
            }
        }

        protected void chkCompleted_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkCompleted = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkCompleted.NamingContainer;
            string goalID = GridView7.DataKeys[row.RowIndex].Value.ToString();
            bool isCompleted = chkCompleted.Checked;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Goal SET IsCompleted = @isCompleted WHERE GoalID = @ID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ID", goalID);
                        command.Parameters.AddWithValue("@isCompleted", isCompleted);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                GridView7.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
            }
        }

    }
}
