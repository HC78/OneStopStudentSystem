using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace fyp
{
    public partial class EditNote : System.Web.UI.Page
    {
        private List<string> imagePaths;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                imagePaths = new List<string>();
                ViewState["ImagePaths"] = imagePaths;

                if (Request.QueryString["NoteID"] != null)
                {
                    string noteID = Request.QueryString["NoteID"];
                    LoadNoteDetails(noteID);
                }
            }
            else
            {
                imagePaths = (List<string>)ViewState["ImagePaths"];
                RestoreImages();
            }
        }

        private void LoadNoteDetails(string noteID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT NoteTakingTitle, NoteTakingDesc, images FROM NoteTaking WHERE NoteTakingID = @noteID", conn);
                    cmd.Parameters.AddWithValue("@noteID", noteID);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtTitle.Text = reader["NoteTakingTitle"].ToString();
                        txtDesc.Text = reader["NoteTakingDesc"].ToString();
                        lblNoteID.Text = noteID;
                        string imagePathsString = reader["images"].ToString();
                        if (!string.IsNullOrWhiteSpace(imagePathsString))
                        {
                            imagePaths.AddRange(imagePathsString.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries));
                            ViewState["ImagePaths"] = imagePaths;
                            RestoreImages();
                        }
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while loading note details: " + ex.Message);
            }
        }

        private void RestoreImages()
        {
            imageContainer.Controls.Clear();
            foreach (string imagePath in imagePaths)
            {
                AddImageToContainer(imagePath);
            }
        }

        private void AddImageToContainer(string imagePath)
        {
            Image img = new Image();
            img.ImageUrl = "~/Image/" + imagePath;
            img.Width = 100;
            img.Height = 100;
            img.Attributes["data-image-path"] = imagePath;

            Button deleteButton = new Button();
            deleteButton.Text = "Delete";
            deleteButton.CommandArgument = imagePath;
            deleteButton.Click += DeleteImage_Click;

            Panel imagePanel = new Panel();
            imagePanel.Controls.Add(img);
            imagePanel.Controls.Add(deleteButton);

            imageContainer.Controls.Add(imagePanel);
        }

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            string noteID = lblNoteID.Text;
            string newTitle = txtTitle.Text.Trim();
            string newDesc = txtDesc.Text.Trim();
            bool hasDuplicates = false;

            // Check for file uploads
            if (fileUpload.HasFiles)
            {
                List<string> newImagePaths = new List<string>();

                foreach (HttpPostedFile uploadedFile in fileUpload.PostedFiles)
                {
                    try
                    {
                        string fileName = Path.GetFileName(uploadedFile.FileName);

                        // Check if the file already exists in the list
                        if (imagePaths.Contains(fileName) || newImagePaths.Contains(fileName))
                        {
                            hasDuplicates = true;
                            continue;
                        }

                        string filePath = Server.MapPath("~/Image/") + fileName;
                        uploadedFile.SaveAs(filePath);

                        // Add the new image to the list
                        newImagePaths.Add(fileName);

                        // Add the new image to the UI container
                        AddImageToContainer(fileName);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("An error occurred while uploading the image: " + ex.Message);
                    }
                }

                // Update the image paths list
                imagePaths.AddRange(newImagePaths);
                ViewState["ImagePaths"] = imagePaths;
            }

            // If duplicates found, display alert message and stop processing
            if (hasDuplicates)
            {
                string alertMessage = "Some images are duplicates and will not be added again.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}');", true);
                return;
            }

            // Update the note details in the database
            if (UpdateNoteInDatabase(noteID, newTitle, newDesc))
            {
                Response.Redirect("NoteTaking.aspx");
            }
        }

        private bool UpdateNoteInDatabase(string noteID, string newTitle, string newDesc)
        {
            if (string.IsNullOrWhiteSpace(newTitle) || string.IsNullOrWhiteSpace(newDesc))
            {
                string alertMessage = "Please enter title and description.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{alertMessage}');", true);
                return false;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Remove deleted images from the list
            string deletedImages = hdnDeletedImages.Value;
            if (!string.IsNullOrWhiteSpace(deletedImages))
            {
                string[] deletedImageArray = deletedImages.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                imagePaths.RemoveAll(image => deletedImageArray.Contains(image));
            }

            string updatedImages = string.Join(",", imagePaths);

            // Update the database
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE NoteTaking SET NoteTakingTitle = @newTitle, NoteTakingDesc = @newDesc, images = @updatedImages WHERE NoteTakingID = @noteID", conn);
                    cmd.Parameters.AddWithValue("@noteID", noteID);
                    cmd.Parameters.AddWithValue("@newTitle", newTitle);
                    cmd.Parameters.AddWithValue("@newDesc", newDesc);
                    cmd.Parameters.AddWithValue("@updatedImages", updatedImages);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while updating the note: " + ex.Message);
                return false;
            }
        }

        protected void DeleteImage_Click(object sender, EventArgs e)
        {
            Button deleteButton = (Button)sender;
            string imagePath = deleteButton.CommandArgument;

            // Remove the image from UI and track it in the hidden field
            foreach (Control control in imageContainer.Controls)
            {
                if (control is Panel panel)
                {
                    Image img = panel.Controls.OfType<Image>().FirstOrDefault(i => i.Attributes["data-image-path"] == imagePath);
                    if (img != null)
                    {
                        imageContainer.Controls.Remove(panel);
                        break;
                    }
                }
            }

            // Track the deleted image in the hidden field
            List<string> deletedImages = hdnDeletedImages.Value.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
            if (!deletedImages.Contains(imagePath))
            {
                deletedImages.Add(imagePath);
                hdnDeletedImages.Value = string.Join(",", deletedImages);
            }

            // Remove from the imagePaths list and update ViewState
            imagePaths.Remove(imagePath);
            ViewState["ImagePaths"] = imagePaths;
        }

        private void UpdateImagesInDatabase(string noteID, List<string> images)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string updatedImages = string.Join(",", images);

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE NoteTaking SET images = @updatedImages WHERE NoteTakingID = @noteID", conn);
                    cmd.Parameters.AddWithValue("@noteID", noteID);
                    cmd.Parameters.AddWithValue("@updatedImages", updatedImages);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while updating the images: " + ex.Message);
            }
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("NoteTaking.aspx");
        }
    }
}
