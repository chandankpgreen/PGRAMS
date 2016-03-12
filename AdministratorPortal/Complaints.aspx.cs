using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

public partial class AuditorPortal_Complaints : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            List<Grievance> Grievances = GetGrievances().Where(x => (x.ResolutionStatus == Grievance.ResolutionStatuses.Approved)).ToList();
            grdComplaints.DataBind();
        }
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
    protected List<Grievance> GetGrievances(string sortexpression = "GrievanceID", SortDirection sortdirection = SortDirection.Ascending)
    {
        ApplicationDbContext dbContext = new ApplicationDbContext();
        string LoggedInUserID = User.Identity.GetUserId();
        List<Grievance> GrievanceList = null;
        int[] InAudit = { 4,6,7,8,9};
        switch (sortexpression)
        {
            case "GrievanceID":
                if (sortdirection == SortDirection.Ascending)
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.GrievanceID ascending
                                     select gr).ToList();
                else
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.GrievanceID descending
                                     select gr).ToList();
                break;
            case "GrievanceType":
                if (sortdirection == SortDirection.Ascending)
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.GrievanceType ascending
                                     select gr).ToList();
                else
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.GrievanceType descending
                                     select gr).ToList();
                break;
            case "GrievanceDescription":
                if (sortdirection == SortDirection.Ascending)
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.GrievanceDescription ascending
                                     select gr).ToList();
                else
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.GrievanceDescription descending
                                     select gr).ToList();
                break;
            case "DateLogged":
                if (sortdirection == SortDirection.Ascending)
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.DateLogged ascending
                                     select gr).ToList();
                else
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.DateLogged descending
                                     select gr).ToList();
                break;
            case "TargetCompletionDate":
                if (sortdirection == SortDirection.Ascending)
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.TargetCompletionDate ascending
                                     select gr).ToList();
                else
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.TargetCompletionDate descending
                                     select gr).ToList();
                break;
            case "ResolutionStatus":
                if (sortdirection == SortDirection.Ascending)
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.ResolutionStatus ascending
                                     select gr).ToList();
                else
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.ResolutionStatus descending
                                     select gr).ToList();
                break;
            default:
                if (sortdirection == SortDirection.Ascending)
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.GrievanceID ascending
                                     select gr).ToList();
                else
                    GrievanceList = (from Grievance gr in dbContext.Grievances
                                     where InAudit.Contains((int)gr.ResolutionStatus)
                                     orderby gr.GrievanceID descending
                                     select gr).ToList();
                break;
        }

        return GrievanceList;
    }

    protected void grdComplaints_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdComplaints.PageIndex = e.NewPageIndex;
        //rebind your gridview - GetSource(),Datasource of your GirdView
        grdComplaints.DataSource = GetGrievances().Where(x => (x.ResolutionStatus == (Grievance.ResolutionStatuses)(Convert.ToInt16(ddlResolutionStatus.SelectedValue)))).ToList();
        grdComplaints.DataBind();
    }
    protected void grdComplaints_Sorting(object sender, GridViewSortEventArgs e)
    {
        //rebind your gridview - GetSource(),Datasource of your GirdView

        SortDirection gridsortdirection = SortDirection.Ascending;
        if (this.ViewState["sortdirection"] != null)
        {
            gridsortdirection = (SortDirection)this.ViewState["sortdirection"];
            gridsortdirection = gridsortdirection.Equals(SortDirection.Ascending) ? SortDirection.Descending : SortDirection.Ascending;
        }
        else
        {
            gridsortdirection = SortDirection.Ascending;
        }
        this.ViewState["sortdirection"] = gridsortdirection;
        this.ViewState["sortexpression"] = e.SortExpression;
        grdComplaints.DataSource = GetGrievances(e.SortExpression, gridsortdirection).Where(x => (x.ResolutionStatus == (Grievance.ResolutionStatuses)(Convert.ToInt16(ddlResolutionStatus.SelectedValue)))).ToList();
        grdComplaints.DataBind();
    }

    // This is a helper method used to determine the index of the
    // column being sorted. If no column is being sorted, -1 is returned.
    int GetSortColumnIndex()
    {

        // Iterate through the Columns collection to determine the index
        // of the column being sorted.
        foreach (DataControlField field in grdComplaints.Columns)
        {
            if (this.ViewState["sortexpression"] == null) { return 1; }

            if (field.SortExpression == (string)this.ViewState["sortexpression"])
            {
                return grdComplaints.Columns.IndexOf(field);
            }
        }

        return -1;
    }
    // This is a helper method used to add a sort direction
    // image to the header of the column being sorted.
    void AddSortImage(int columnIndex, GridViewRow headerRow)
    {

        // Create the sorting image based on the sort direction.
        Image sortImage = new Image();
        sortImage.Height = 20;
        sortImage.Width = 15;
        sortImage.ImageAlign = ImageAlign.Right;
        if (this.ViewState["sortdirection"] == null || (SortDirection)this.ViewState["sortdirection"] == SortDirection.Ascending)
        {
            sortImage.ImageUrl = "~/Content/images/ascending.png";
            sortImage.AlternateText = "Ascending Order";
        }
        else
        {
            sortImage.ImageUrl = "~/Content/images/descending.png";
            sortImage.AlternateText = "Descending Order";
        }

        // Add the image to the appropriate header cell.
        headerRow.Cells[columnIndex].Controls.Add(sortImage);

    }
    protected void grdComplaints_RowCreated(object sender, GridViewRowEventArgs e)
    {
        // Use the RowType property to determine whether the 
        // row being created is the header row. 
        if (e.Row.RowType == DataControlRowType.Header)
        {
            // Call the GetSortColumnIndex helper method to determine
            // the index of the column being sorted.
            int sortColumnIndex = GetSortColumnIndex();

            if (sortColumnIndex != -1)
            {
                // Call the AddSortImage helper method to add
                // a sort direction image to the appropriate
                // column header. 
                AddSortImage(sortColumnIndex, e.Row);
            }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        int[] InAudit = { 4,6,7,8,9};
        ApplicationDbContext dbContext = new ApplicationDbContext();
        string LoggedInUserID = User.Identity.GetUserId();
        long GrievanceID;
        List<Grievance> Grievances;
        if (long.TryParse(txtSearch.Text, out GrievanceID))
        {
            Grievances = (from Grievance gr in dbContext.Grievances
                          where (InAudit.Contains((int)gr.ResolutionStatus)
                          && gr.GrievanceID.ToString().Contains(GrievanceID.ToString()))
                          orderby gr.GrievanceID ascending
                          select gr).ToList();
        }
        else
        {
            List<Grievance> AllGrievance = (from Grievance gr in dbContext.Grievances
                                            where (gr.Complainant.Id == LoggedInUserID)
                                            select gr).ToList();
            Grievances = new List<Grievance>();
            foreach (Grievance gr in AllGrievance)
            {
                if (gr.Complainant.Id == LoggedInUserID)
                {
                    if (gr.GrievanceDescription.ToString().IndexOf(txtSearch.Text, StringComparison.CurrentCultureIgnoreCase) >= 0
                          || (gr.GrievanceType.GetDescription().IndexOf(txtSearch.Text, StringComparison.CurrentCultureIgnoreCase) >= 0))
                    {
                        Grievances.Add(gr);
                    }
                }
            }
        }
        grdComplaints.DataSource = Grievances;
        grdComplaints.DataBind();
    }
    protected void ddlResolutionStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        List<Grievance> Grievances = GetGrievances().Where(x => (x.ResolutionStatus == (Grievance.ResolutionStatuses)(Convert.ToInt16(ddlResolutionStatus.SelectedValue)))).ToList();
        grdComplaints.DataSource = Grievances;
        grdComplaints.DataBind();
    }
}