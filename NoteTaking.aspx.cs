using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace fyp
{
    public partial class NoteTaking : System.Web.UI.Page
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
                LoadNotes();
                lblError0.Visible = false;
                lblError1.Visible = false;
                lblError2.Visible = false;
                lblError3.Visible = false;
                lblError.Text = "";
            }
            else
            {
                LoadNotes();
                lblError0.Visible = false;
                lblError1.Visible = false;
                lblError2.Visible = false;
                lblError3.Visible = false;
                lblError.Text = "";

            }
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            if (AddNoteToDatabase(txtTitle.Text, txtDesc.Text, ColorPicker.Value, txtCourse.Text, txtWeek.Text))
            {
                LoadNotes();
                txtTitle.Text = string.Empty;
                txtDesc.Text = string.Empty;
                txtWeek.Text = string.Empty;
                txtCourse.Text = string.Empty;
                lblError.Text = string.Empty;
                lblError0.Visible = false;
                lblError1.Visible = false;
                lblError2.Visible = false;
                lblError3.Visible = false;

                CheckNote(noNoteMessage1);
            }
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            txtTitle.Text = string.Empty;
            txtDesc.Text = string.Empty;
            ColorPicker.Value = "#eeeeee";
            txtWeek.Text = string.Empty;
            txtCourse.Text = string.Empty;
            lblError.Text = string.Empty;
            lblError0.Visible = false;
            lblError1.Visible = false;
            lblError2.Visible = false;
            lblError3.Visible = false;
            fileUpload.Attributes.Clear();

        }

        private bool AddNoteToDatabase(string NoteTitle, string NoteDesc, string colour, string course, string week)
        {
            bool complete = true;

            if (string.IsNullOrWhiteSpace(NoteTitle))
            {
                lblError0.Visible = true;
                complete = false;
            }
            if (string.IsNullOrWhiteSpace(NoteDesc))
            {
                lblError1.Visible = true;
                complete = false;
            }
            if (string.IsNullOrWhiteSpace(course))
            {
                lblError2.Visible = true;
                complete = false;
            }
            if (string.IsNullOrWhiteSpace(week))
            {
                lblError3.Visible = true;
                complete = false;
            }
            if (!complete)
            {
                lblError.Text = "Please fill up the required field.";
                return false;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();
            string newNoteID = GenerateNextID();

            List<string> imagePaths = new List<string>();
       //     List<string> duplicateFiles = new List<string>();
            if (fileUpload.HasFiles)
            {
                foreach (HttpPostedFile uploadedFile in fileUpload.PostedFiles)
                {
                    string filename = Path.GetFileName(uploadedFile.FileName);

                    string serverPath = Server.MapPath("~/Image/") + filename;

                    
                     uploadedFile.SaveAs(serverPath);
                     imagePaths.Add(filename);
                    
                }
            }

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO NoteTaking (NoteTakingID, NoteTakingTitle, NoteTakingDesc, studentID, noteColor, Course, Week, DateCreated, images) VALUES (@ID, @title, @desc, @studentID, @color, @course, @week, @date, @images)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ID", newNoteID);
                        command.Parameters.AddWithValue("@title", NoteTitle);
                        command.Parameters.AddWithValue("@desc", NoteDesc);
                        command.Parameters.AddWithValue("@studentID", studentID);
                        command.Parameters.AddWithValue("@color", colour);
                        command.Parameters.AddWithValue("@course", course);
                        command.Parameters.AddWithValue("@week", week);
                        command.Parameters.AddWithValue("@date", DateTime.Now);
                        command.Parameters.AddWithValue("@images", string.Join(",", imagePaths));

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                    GridView1.DataBind();
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
            string newID = "NT001";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT TOP 1 NoteTakingID FROM NoteTaking ORDER BY NoteTakingID DESC", conn);
                    var result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        string lastID = result.ToString();
                        int num = int.Parse(lastID.Substring(2)) + 1;
                        newID = "NT" + num.ToString("D3");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while generating new ID: " + ex.Message);
            }

            return newID;
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            LoadNotes(txtSearchWeek.Text, txtSearchCourse.Text);
        }


        private void LoadNotes(string searchWeek, string searchCourse)
        {
            noteContainer.Controls.Clear();

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();

            string query = "SELECT  NoteTakingID, NoteTakingTitle, NoteTakingDesc, noteColor, Course, Week, DateCreated, images FROM NoteTaking WHERE studentID = @studentID";

            if (!string.IsNullOrEmpty(searchWeek))
            {
                query += " AND Week LIKE @searchWeek";
            }

            if (!string.IsNullOrEmpty(searchCourse))
            {
                query += " AND Course LIKE @searchCourse";
            }
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@studentID", studentID);
                    if (!string.IsNullOrEmpty(searchWeek))
                    {
                        cmd.Parameters.AddWithValue("@searchWeek", "%" + searchWeek + "%");
                    }

                    if (!string.IsNullOrEmpty(searchCourse))
                    {
                        cmd.Parameters.AddWithValue("@searchCourse", "%" + searchCourse + "%");
                    }

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string noteID = reader["NoteTakingID"].ToString();
                        string title = reader["NoteTakingTitle"].ToString();
                        string desc = reader["NoteTakingDesc"].ToString();
                        string color = reader["noteColor"].ToString();
                        string course = reader["Course"].ToString();
                        string week = reader["Week"].ToString();
                        string dateCreated = reader["DateCreated"].ToString();
                        string image = reader["images"].ToString();
                        AddNoteToPage(noteID, title, desc, color, course, week, dateCreated, image);
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while loading notes: " + ex.Message);
            }
        }

        private void LoadNotes()
        {
            noteContainer.Controls.Clear();

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT NoteTakingID, NoteTakingTitle, NoteTakingDesc, noteColor, Course, Week, DateCreated, images FROM NoteTaking WHERE studentID = @studentID", conn);
                    cmd.Parameters.AddWithValue("@studentID", studentID);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string noteID = reader["NoteTakingID"].ToString();
                        string title = reader["NoteTakingTitle"].ToString();
                        string desc = reader["NoteTakingDesc"].ToString();
                        string color = reader["noteColor"].ToString();
                        string course = reader["Course"].ToString();
                        string week = reader["Week"].ToString();
                        string dateCreated = reader["DateCreated"].ToString();
                        string image = reader["images"].ToString();
                        AddNoteToPage(noteID, title, desc, color, course, week, dateCreated, image);
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while loading notes: " + ex.Message);
            }
        }

        private void AddNoteToPage(string noteID, string title, string desc, string color, string course, string week, string date, string image)
        {
            Panel notePanel = new Panel();
            notePanel.CssClass = "note";
            notePanel.Style.Add("background-color", color);

            Label titleLabel = new Label();
            titleLabel.Text = title;
            titleLabel.Font.Bold = true;

            Label descLabel = new Label();
            descLabel.Text = desc;

            Label dateLabel = new Label();
            dateLabel.Text = " ( " + date + " )";

            Label courseLabel = new Label();
            courseLabel.Text = course;
            courseLabel.Font.Bold = true;
            courseLabel.Font.Underline = true;

            Label weekLabel = new Label();
            weekLabel.Text = "Week" + week + " ";


            notePanel.Controls.Add(weekLabel);
            notePanel.Controls.Add(dateLabel);
            notePanel.Controls.Add(new LiteralControl("<br />"));
            notePanel.Controls.Add(courseLabel);
            notePanel.Controls.Add(new LiteralControl("<br />"));

            if (!string.IsNullOrWhiteSpace(image))
            {
                string[] images = image.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string imagePath in images)
                {
                    Image img = new Image();
                    img.ImageUrl = "~/Image/" + imagePath;
                    img.Width = 100;
                    img.Height = 100;
                    notePanel.Controls.Add(img);
                }
                notePanel.Controls.Add(new LiteralControl("<br />"));
            }


            notePanel.Controls.Add(titleLabel);
            notePanel.Controls.Add(new LiteralControl("<br />"));
            notePanel.Controls.Add(descLabel);
            notePanel.Controls.Add(new LiteralControl("<br />"));


            // Add Edit Button
            Button editButton = new Button();
            editButton.ID = $"editButton_{noteID}";
            editButton.Text = "Edit";
            editButton.CssClass = "edit-button";
            editButton.CommandArgument = noteID;
            editButton.Click += EditButton_Click;
            notePanel.Controls.Add(editButton);

            notePanel.Controls.Add(new LiteralControl("  "));
            // Add Delete Button
            Button deleteButton = new Button();
            deleteButton.ID = $"deleteButton_{noteID}";
            deleteButton.Text = "Delete";
            deleteButton.CssClass = "delete-button";
            deleteButton.CommandArgument = noteID;
            deleteButton.Click += DeleteButton_Click;
            notePanel.Controls.Add(deleteButton);

            noteContainer.Controls.Add(notePanel);
        }


        protected void EditButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string noteID = btn.CommandArgument;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT NoteTakingTitle, NoteTakingDesc, noteColor, images FROM NoteTaking WHERE NoteTakingID = @noteID", conn);
                    cmd.Parameters.AddWithValue("@noteID", noteID);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        string title = reader["NoteTakingTitle"].ToString();
                        string desc = reader["NoteTakingDesc"].ToString();
                        string color = reader["noteColor"].ToString();
                        string image = reader["images"].ToString();
                        Response.Redirect($"EditNote.aspx?NoteID={noteID}");
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while editing note: " + ex.Message);
            }
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string noteID = btn.CommandArgument;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM NoteTaking WHERE NoteTakingID = @noteID", conn);
                    cmd.Parameters.AddWithValue("@noteID", noteID);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        LoadNotes();
                        CheckNote(noNoteMessage1);
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while deleting note: " + ex.Message);
            }
        }


        private void CheckNote(Label label)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string studentID = Session["UserID"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM NoteTaking WHERE studentID = @studentID", conn);
                    cmd.Parameters.AddWithValue("@studentID", studentID);

                    int NoteCount = (int)cmd.ExecuteScalar();
                    label.Visible = (NoteCount == 0);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while checking tasks: " + ex.Message);
            }
        }

        protected void txtWeek_TextChanged(object sender, EventArgs e)
        {

        }
    }

}
