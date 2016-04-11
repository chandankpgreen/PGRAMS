using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdministratorPortal_Reports : System.Web.UI.Page
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
        List<Employee> emplist;
        List<ResolutionTask> tasklist;
        List<Grievance> grlist;
        DateTime startDate = Convert.ToDateTime(txtFromDate.Text);
        DateTime endDate = Convert.ToDateTime(txtEndDate.Text);
        using (ApplicationDbContext DbContext = new ApplicationDbContext())
        {
            switch (ddlReport.SelectedIndex)
            {
                case 0:
                    
                    emplist = (from Employee emp in DbContext.Employees
                               select emp).ToList();
                    dt = new DataTable();
                    dt.Columns.Add(new DataColumn("EmployeeID"));
                    dt.Columns.Add(new DataColumn("Employee Name"));
                    dt.Columns.Add(new DataColumn("No. of tasks assigned"));
                    foreach (Employee emp in emplist)
                    {
                        tasklist = (from ResolutionTask task in DbContext.ResolutionTasks
                                        where task.Status  != ResolutionTask.TaskStatus.Completed
                                        && task.Resolver.EmployeeID == emp.EmployeeID
                                        select task).ToList();
                        dt.Rows.Add(emp.EmployeeID, emp.FirstName + " " + emp.LastName,tasklist.Count);
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
                    dt.Columns.Add(new DataColumn("Men required"));
                    dt.Columns.Add(new DataColumn("Total Cost"));
                    foreach (Grievance gr in grlist)
                    {
                        tasklist = gr.ResolutionTasks.ToList();
                        long Menrequired = 0;
                        decimal TotalCost = 0;
                        foreach (ResolutionTask task in gr.ResolutionTasks)
                        {
                            Menrequired += task.MenReqired;
                            TotalCost += task.TaskBudget;
                        }
                        dt.Rows.Add(gr.GrievanceID, gr.GrievanceDescription, Menrequired, TotalCost);
                    }
                    break;
                case 2:
                    grlist = (from Grievance gr in DbContext.Grievances
                              where gr.DateLogged >= startDate
                              && gr.DateLogged <= endDate
                              select gr).ToList();
                    dt = new DataTable();
                    dt.Columns.Add(new DataColumn("Department"));
                    dt.Columns.Add(new DataColumn("Men Required"));
                    dt.Columns.Add(new DataColumn("Total CostCost"));

                    Array values = Enum.GetValues(typeof(Grievance.GrievanceTypes));
                    foreach (int value in values)
                    {
                        long Menrequired = 0;
                        foreach (Grievance gr in grlist)
                        {
                            if (gr.GrievanceType == (Grievance.GrievanceTypes)value)
                            {
                                foreach (ResolutionTask task in gr.ResolutionTasks)
                                {
                                    Menrequired += task.MenReqired;
                                }
                            }
                        }

                        decimal CostIncurred = 0;
                        foreach (Grievance gr in grlist)
                        {
                            if (gr.GrievanceType == (Grievance.GrievanceTypes)value)
                            {
                                foreach (ResolutionTask task in gr.ResolutionTasks)
                                {
                                    CostIncurred += task.TaskBudget;
                                }
                            }
                        }

                        dt.Rows.Add(Enum.GetName(typeof(Grievance.GrievanceTypes), value), Menrequired,CostIncurred);

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