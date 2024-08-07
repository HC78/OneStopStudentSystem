using Google.Apis.Auth.OAuth2;
using Google.Apis.Calendar.v3;
using Google.Apis.Services;
using System;
using System.Threading;
using System.Web.UI;

namespace OneStopStudentSystem
{
    public partial class oauth2callback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string clientId = "784717365865-ifv33pg2c1m3dukr6j46ri4s89n9j60g.apps.googleusercontent.com";
            string clientSecret = "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";
            string redirectUri = "https://localhost:44355/oauth2callback.aspx"; // Adjust for your environment

            if (!string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                string code = Request.QueryString["code"];

                try
                {
                    // Exchange the authorization code for access and refresh tokens
                    UserCredential credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                        new ClientSecrets
                        {
                            ClientId = clientId,
                            ClientSecret = clientSecret
                        },
                        new[] { CalendarService.Scope.Calendar },
                        code,
                        CancellationToken.None).Result;

                    // Store the credential somewhere secure (e.g., database) for future use
                    // You'll need this credential to interact with Google Calendar on behalf of the user

                    Response.Redirect("~/Reminder.aspx"); // Redirect to your main page after authorization
                }
                catch (Exception ex)
                {
                    // Handle errors appropriately
                    Console.WriteLine($"Error authorizing Google Calendar API: {ex.Message}");
                    // Redirect to an error page or display an error message
                    Response.Redirect("~/Error.aspx");
                }
            }
            else if (!string.IsNullOrEmpty(Request.QueryString["error"]))
            {
                // Handle error responses from Google (e.g., user denied access)
                string error = Request.QueryString["error"];
                Console.WriteLine($"Error from Google authorization: {error}");
                // Redirect to an error page or display an error message
                Response.Redirect("~/Error.aspx");
            }
            else
            {
                // Redirect to an error page or display an error message if the code or error query string parameters are missing
                Response.Redirect("~/Error.aspx");
            }
        }
    }
}