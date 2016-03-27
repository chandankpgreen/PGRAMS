using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AuditorPortal_Reports : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnGetReport_Click(object sender, EventArgs e)
    {
        grdReport.DataSource = GetTable();
        grdReport.DataBind();
    }

    protected DataTable GetTable()
    {
        DataTable dt = new DataTable();
        List<Grievance> grlist;
        TimeSpan ts = new TimeSpan();
        DateTime startDate = Convert.ToDateTime(txtFromDate.Text);
        DateTime endDate = Convert.ToDateTime(txtEndDate.Text);
        using (ApplicationDbContext DbContext = new ApplicationDbContext())
        {
            switch (ddlReport.SelectedIndex)
            {
                case 0:
                    grlist = (from Grievance gr in DbContext.Grievances
                              where gr.DateLogged >= startDate
                              && gr.DateLogged <= endDate
                              select gr).ToList();
                    dt = new DataTable();
                    dt.Columns.Add(new DataColumn("GrievanceID"));
                    dt.Columns.Add(new DataColumn("Grievance Description"));
                    dt.Columns.Add(new DataColumn("Kick off Delay"));
                    foreach (Grievance gr in grlist)
                    {

                        if (gr.ResolutionStatus == Grievance.ResolutionStatuses.Created)
                        {
                            ts = DateTime.Now - gr.DateLogged;
                            dt.Rows.Add(gr.GrievanceID, gr.GrievanceDescription, ts.Days + " day(s) " + ts.Hours + " hrs");
                        }
                    }
                    break;
                case 1:
                    grlist = (from Grievance gr in DbContext.Grievances
                              where gr.DateLogged >= startDate
                              && gr.DateLogged <= endDate
                              select gr).ToList();
                    dt = new DataTable();
                    dt.Columns.Add(new DataColumn("GrievanceID"));
                    dt.Columns.Add(new DataColumn("Grievance Description"));
                    dt.Columns.Add(new DataColumn("Resolution Delay"));
                    foreach (Grievance gr in grlist)
                    {
                        if (gr.ResolutionStatus == Grievance.ResolutionStatuses.Completed)
                        {
                            ResolutionTask latestrestask = (from ResolutionTask tk in gr.ResolutionTasks
                                                            select tk).OrderByDescending(x => x.ActualCompletionDate).FirstOrDefault();
                            if (latestrestask.ActualCompletionDate.HasValue && gr.TargetCompletionDate.HasValue)
                            {
                                ts = (DateTime)latestrestask.ActualCompletionDate - (DateTime)gr.TargetCompletionDate;
                                dt.Rows.Add(gr.GrievanceID, gr.GrievanceDescription, ts.Days + " day(s) " + ts.Hours + " hrs");
                            }
                        }
                    }
                    break;
                case 2:
                    grlist = (from Grievance gr in DbContext.Grievances
                              where gr.DateLogged >= startDate
                              && gr.DateLogged <= endDate
                              select gr).ToList();
                    dt = new DataTable();
                    dt.Columns.Add(new DataColumn("GrievanceID"));
                    dt.Columns.Add(new DataColumn("Grievance Description"));
                    dt.Columns.Add(new DataColumn("Is Satisfied"));
                    foreach (Grievance gr in grlist)
                    {
                        if (gr.ResolutionStatus == Grievance.ResolutionStatuses.Verified)
                        {
                            dt.Rows.Add(gr.GrievanceID, gr.GrievanceDescription, "Yes");
                        }
                        if (gr.ResolutionStatus == Grievance.ResolutionStatuses.Reopened)
                        {
                            dt.Rows.Add(gr.GrievanceID, gr.GrievanceDescription, "No");
                        }
                    }
                    break;
            }
        }
        return dt;
    }
    protected void btnExportReport_Click(object sender, EventArgs e)
    {

        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = ddlReport.SelectedValue + "_" + txtFromDate + "-to-" + txtEndDate + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        string tab = "";
        DataTable table = GetTable();
        foreach (DataColumn dc in table.Columns)
        {
            Response.Write(tab + dc.ColumnName);
            tab = "\t";
        }
        Response.Write("\n");
        int i;
        foreach (DataRow dr in table.Rows)
        {
            tab = "";
            for (i = 0; i < table.Columns.Count; i++)
            {
                Response.Write(tab + dr[i].ToString());
                tab = "\t";
            }
            Response.Write("\n");
        }
        Response.End();
    }
}