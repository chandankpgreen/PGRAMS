using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;


public partial class ComplainantPortal_Feedback : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       using (ApplicationDbContext DbContext = new ApplicationDbContext()){
            Complainant LoggedInComplainant =  DbContext.Complainants.ToList().Where(x=>(x.Id ==User.Identity.GetUserId())).FirstOrDefault() ;
            IEnumerable<Grievance> grlist = (from Grievance gr in DbContext.Grievances
                   where gr.Complainant.Id == LoggedInComplainant.Id
                   && (gr.ResolutionStatus == Grievance.ResolutionStatuses.Verified ||gr.ResolutionStatus == Grievance.ResolutionStatuses.Reopened||gr.ResolutionStatus == Grievance.ResolutionStatuses.Flagged ||gr.ResolutionStatus == Grievance.ResolutionStatuses.OnHold)
                   select gr).ToList();
            ddlComplaint.DataSource = grlist;
            ddlComplaint.DataTextField = "GrievanceID";
            ddlComplaint.DataValueField = "GrievanceID";
            ddlComplaint.DataBind();
       }
        
    }
    protected void ddlComplaint_SelectedIndexChanged(object sender, EventArgs e)
    {
        using (ApplicationDbContext DbContext = new ApplicationDbContext())
        {
            Complainant LoggedInComplainant = DbContext.Complainants.ToList().Where(x => (x.Id == User.Identity.GetUserId())).FirstOrDefault();
           Grievance grievance = (from Grievance gr in DbContext.Grievances
                                             where gr.Complainant.Id == LoggedInComplainant.Id
                                             && (gr.ResolutionStatus == Grievance.ResolutionStatuses.Verified || gr.ResolutionStatus == Grievance.ResolutionStatuses.Reopened || gr.ResolutionStatus == Grievance.ResolutionStatuses.Flagged || gr.ResolutionStatus == Grievance.ResolutionStatuses.OnHold)
                                             && gr.GrievanceID.ToString() == ddlComplaint.SelectedValue.ToString()
                                             select gr).ToList().FirstOrDefault();
           ltlComplaintDescription.Text = grievance.GrievanceDescription;
        }
    }
    protected void btnRegisterFeedback_Click(object sender, EventArgs e)
    {
        using (ApplicationDbContext DbContext = new ApplicationDbContext())
        {
            Complainant LoggedInComplainant = DbContext.Complainants.ToList().Where(x => (x.Id == User.Identity.GetUserId())).FirstOrDefault();

            Feedback fb = new Feedback()
            {
                Grievance = (from Grievance gr in DbContext.Grievances
                                             where gr.Complainant.Id == LoggedInComplainant.Id
                                             && (gr.ResolutionStatus == Grievance.ResolutionStatuses.Verified || gr.ResolutionStatus == Grievance.ResolutionStatuses.Reopened || gr.ResolutionStatus == Grievance.ResolutionStatuses.Flagged || gr.ResolutionStatus == Grievance.ResolutionStatuses.OnHold)
                                             && gr.GrievanceID.ToString() == ddlComplaint.SelectedValue.ToString()
                                             select gr).ToList().FirstOrDefault(),
                Comment = txtComplaintDescription.Text,
                Complainant = LoggedInComplainant

            };
            DbContext.Feedbacks.Add(fb);
            DbContext.SaveChanges();

            SuccessMessage.Text = "Your feedback has been saved successfully.";
            SuccessPlaceHolder.Visible = true;
        }
    }
}