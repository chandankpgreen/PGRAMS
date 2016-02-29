using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using PGRAMS_CS;
using System.Linq;
using System.Data.Entity;

public partial class Account_Login : Page
{
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterHyperLink.NavigateUrl = "Register";
            OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];
            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!String.IsNullOrEmpty(returnUrl))
            {
                RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // Validate the user password
                var userMgr = new UserManager();
                var thisUsers = userMgr.Users;

                ApplicationUser user = userMgr.Find(UserName.Text, Password.Text);
                if (user != null)
                {
                    if (!userMgr.IsInRole(user.Id, rdUserRole.Text))
                    {
                        FailureText.Text = "Invalid username or password";
                        ErrorMessage.Visible = true;
                        return;
                    }
                    IdentityHelper.SignIn(userMgr, user, RememberMe.Checked);
                    //ApplicationDbContext dbcon = new ApplicationDbContext();
                    
                    //Grievance gr = new Grievance();
                    //gr.GrievanceDescription ="hello";
                    //gr.DateLogged = DateTime.Now;
                    //gr.TargetCompletionDate = DateTime.Now;
                    //gr.ResolutionStatus = Grievance.ResolutionStatuses.Created;
                    ////gr.DateLogged = DateTime.Now;
                    //dbcon.Grievances.Add(gr);
                    //dbcon.SaveChanges();
                    if (rdUserRole.Text == "Auditor")
                    {
                        Response.Redirect("~/AuditorPortal/Complaints.aspx");
                    }
                    else if (rdUserRole.Text == "Administrator")
                    {

                    }
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                else
                {
                    FailureText.Text = "Invalid username or password.";
                    ErrorMessage.Visible = true;
                }
            }
        }
}