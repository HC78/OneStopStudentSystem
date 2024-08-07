using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OneStopStudentSystem
{
    public partial class GCallback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        //    try
        //    {
        //        var authenticationManager = Context.GetOwinContext().Authentication;
        //        var loginInfo = authenticationManager.GetExternalLoginInfo();

        //        if (loginInfo != null)
        //        {
        //            var claimsIdentity = new ClaimsIdentity(loginInfo.ExternalIdentity.Claims, DefaultAuthenticationTypes.ApplicationCookie);
        //            authenticationManager.SignIn(new AuthenticationProperties { IsPersistent = true }, claimsIdentity);

        //            // Extract user info and store in session or database
        //            var emailClaim = claimsIdentity.FindFirst(ClaimTypes.Email);
        //            if (emailClaim != null)
        //            {
        //                Session["Username"] = emailClaim.Value;
        //                Response.Redirect("~/Homepage.aspx");
        //            }
        //        }
        //        else
        //        {
        //            Response.Redirect("~/Login.aspx");
        //        }
        //    }

        //    catch (Exception ex)
        //    {
        //        // Log the exception
        //        Debug.WriteLine($"Exception in GoogleLoginCallback Page_Load: {ex.Message}");

        //        // Redirect to error page
        //        Response.Redirect("~/Error.aspx");
        //    }
        }
    }
}