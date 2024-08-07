using Google.Apis.Auth.OAuth2;
using Google.Apis.Calendar.v3;
using Google.Apis.Calendar.v3.Data;
using Google.Apis.Services;
using Microsoft.AspNet.Identity;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.Google;
using Owin;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;

[assembly: OwinStartup(typeof(OneStopStudentSystem.Startup))]
namespace OneStopStudentSystem
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                LoginPath = new PathString("/Login.aspx")
            });

            app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie);

            var googleOAuth2AuthenticationOptions = new GoogleOAuth2AuthenticationOptions
            {
                ClientId = "784717365865-enram9uscljmvl555t4ikkqn1f11lsc4.apps.googleusercontent.com",
                ClientSecret = "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",
                CallbackPath = new PathString("/GLCallback"),
                Provider = new GoogleOAuth2AuthenticationProvider
                {
                    OnAuthenticated = async context =>
                    {
                        var accessToken = context.AccessToken;
                        var email = context.Identity.FindFirst(System.Security.Claims.ClaimTypes.Email).Value;
                      
                        StoreAccessToken(email, accessToken);
                    }
                }
            };

            // Add scopes
            googleOAuth2AuthenticationOptions.Scope.Add("email");
            googleOAuth2AuthenticationOptions.Scope.Add(CalendarService.Scope.Calendar);

            app.UseGoogleAuthentication(googleOAuth2AuthenticationOptions);
        }
        private void StoreAccessToken(string email, string accessToken)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "UPDATE Student SET AccessToken = @AccessToken WHERE studentEmail = @Email";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@AccessToken", accessToken);
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}