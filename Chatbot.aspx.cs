using System;
using System.Diagnostics;
using System.IO;
using System.Web.UI;

namespace OneStopStudentSystem
{
    public partial class Chatbot : System.Web.UI.Page
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
                // Display greeting message
                litChat.Text = "<div class='chat-bubble bot-bubble'>Hello! How can I assist you today?</div>";
            }
        }

        protected void btnAsk_Click(object sender, EventArgs e)
        {
            string userInput = txtQuestion.Text.Trim();
            if (string.IsNullOrEmpty(userInput))
            {
                return;
            }

            // Display user question
            litChat.Text += $"<div class='chat-bubble user-bubble'>{userInput}</div>";

            // Get chatbot response
            string response = GetChatbotResponse(userInput);

            // Display chatbot response
            litChat.Text += $"<div class='chat-bubble bot-bubble'>{response}</div>";

            // Clear user input
            txtQuestion.Text = "";

            // Scroll to bottom
            ScriptManager.RegisterStartupScript(this, GetType(), "scrollChatbox", "document.getElementById('chatbox').scrollTop = document.getElementById('chatbox').scrollHeight;", true);
        }

        private string GetChatbotResponse(string userInput)
        {
            string batchFilePath = @"C:\Users\SEOW HUI CHEE\source\repos\OneStopStudentSystem\run_chatbot.bat";
            string command = $"\"{batchFilePath}\" \"{userInput}\"";

            ProcessStartInfo startInfo = new ProcessStartInfo
            {
                FileName = "cmd.exe",
                Arguments = $"/c \"{command}\"",
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                UseShellExecute = false,
                CreateNoWindow = true
            };

            try
            {
                using (Process process = Process.Start(startInfo))
                {
                    using (StreamReader outputReader = process.StandardOutput)
                    {
                        using (StreamReader errorReader = process.StandardError)
                        {
                            string output = outputReader.ReadToEnd();
                            string error = errorReader.ReadToEnd();

                            process.WaitForExit();

                            if (!string.IsNullOrEmpty(error))
                            {
                                File.WriteAllText(@"C:\Users\SEOW HUI CHEE\source\repos\OneStopStudentSystem\error.txt", error);
                                return "An error occurred while processing your request.";
                            }

                            return output;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                File.WriteAllText(@"C:\Users\SEOW HUI CHEE\source\repos\OneStopStudentSystem\exception.txt", ex.ToString());
                return "An error occurred while processing your request.";
            }
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            txtQuestion.Text = "";
        }
    }
}
