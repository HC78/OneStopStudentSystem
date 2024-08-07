using Google.Apis.Auth.OAuth2;
using Google.Apis.Calendar.v3;
using Google.Apis.Util.Store;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace fyp
{
    public partial class GLCallbackCalendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string[] scopes = { CalendarService.Scope.Calendar };
            var clientSecrets = new ClientSecrets
            {
                ClientId = "784717365865-enram9uscljmvl555t4ikkqn1f11lsc4.apps.googleusercontent.com",
                ClientSecret = "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",
            };

            var redirectUri = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/GLCallbackCalendar.aspx";

            var code = Request.QueryString["code"];
            var token = GoogleWebAuthorizationBroker.AuthorizeAsync(
                clientSecrets,
                scopes,
                "user",
                CancellationToken.None,
                new FileDataStore("Calendar.Auth.Store")).Result;

            Response.Redirect("~/Homepage.aspx", false); 
        }
    }
}