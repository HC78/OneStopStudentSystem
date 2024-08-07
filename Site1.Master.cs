using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OneStopStudentSystem
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    // User is logged in
                    loginLink.Visible = false; 
                    logoutLink.Visible = true; 
                    lblShowUsername.Text = Session["Username"].ToString();
                    welcomeContainer.Visible = true; 
                }
                else
                {
                    // User is not logged in
                    loginLink.Visible = true;
                    logoutLink.Visible = false;
                    lblShowUsername.Text = "";
                    welcomeContainer.Visible = false;
                }
            }
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear(); 
            Session.Abandon();
            Response.Redirect("~/Login.aspx?logout=true");
            lblShowUsername.Text = "";
            welcomeContainer.Visible = false;
        }

        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {

        }
    }

}