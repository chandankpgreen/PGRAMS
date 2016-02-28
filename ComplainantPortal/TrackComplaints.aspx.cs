using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

public partial class ComplainantPortal_TrackComplaints : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
        ApplicationDbContext dbContext = new ApplicationDbContext();
        string LoggedInUserID =  User.Identity.GetUserId();
        grdComplaints.DataSource = (from Grievance gr in dbContext.Grievances
                                    where gr.Complainant.Id == LoggedInUserID
                                    select gr).ToList();
        grdComplaints.DataBind();

        string Result = Request.QueryString["Result"];
        if (Result == "Success")
        {
            SuccessMessage.Text = "Your complaint has been successfully logged.";
            SuccessPlaceHolder.Visible = true;
        }
    }
    protected void btnVerified_Click(object sender, EventArgs e)
    {
        
    }
    protected void grdComplaints_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Grievance.GrievanceTypes val = (Grievance.GrievanceTypes)Enum.Parse(typeof(Grievance.GrievanceTypes), e.Row.Cells[2].Text);
            e.Row.Cells[2].Text = val.GetDescription();

            Grievance.ResolutionStatuses val2 = (Grievance.ResolutionStatuses)Enum.Parse(typeof(Grievance.ResolutionStatuses), e.Row.Cells[6].Text);
            e.Row.Cells[6].Text = val2.GetDescription();
        }
    }
}