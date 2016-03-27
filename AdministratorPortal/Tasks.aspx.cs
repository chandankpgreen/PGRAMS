using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

public partial class AdministratorPortal_Tasks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            BindComplaints();
            BindEmployees();
            BindTasks();

            string GrievanceIDStr = Request.QueryString["GrievanceID"];
            long GrievanceID;
            if (long.TryParse(GrievanceIDStr, out GrievanceID))
            {
                ddlComplaints.SelectedValue = GrievanceID.ToString();
                ShowTaskDescription();
            }
        }
    }
    protected void BindComplaints()
    {
        ApplicationDbContext dbContext = new ApplicationDbContext();
        int[] inAdmin = { 4, 6, 7, 8, 9 };
        List<Grievance> GrievanceList = (from Grievance gr in dbContext.Grievances
                                         where inAdmin.Contains((int)gr.ResolutionStatus)
                                         orderby gr.GrievanceID ascending
                                         select gr).ToList();
        ddlComplaints.DataSource = GrievanceList;
        ddlComplaints.DataTextField = "GrievanceID";
        ddlComplaints.DataValueField = "GrievanceID";
        ddlComplaints.DataBind();
    }
    protected void BindEmployees()
    {
        ApplicationDbContext dbContext = new ApplicationDbContext();
        var userMgr = new UserManager();
        ddlEmployee.Items.Clear();

        List<Employee> EmployeeList = (from Employee emp in dbContext.Employees
                                       where emp.Department == (from Grievance gr in dbContext.Grievances
                                                                where gr.GrievanceID.ToString() == ddlComplaints.SelectedValue
                                                                select gr.GrievanceType).FirstOrDefault()
                                       orderby emp.EmployeeID
                                       select emp).ToList();
        foreach (Employee emp in EmployeeList)
        {
            if (userMgr.IsInRole(emp.Id, "Employee"))
            {
                ddlEmployee.Items.Add(new ListItem(emp.EmployeeID + " :" + emp.FirstName + " " + emp.LastName, emp.EmployeeID.ToString()));
            }
        }
    }
    protected void BindTasks()
    {
        using (ApplicationDbContext dbContext = new ApplicationDbContext())
        {
            List<ResolutionTask> resouoltionTasks = (from ResolutionTask rs in dbContext.ResolutionTasks
                                                     where rs.Grievance.GrievanceID.ToString() == ddlComplaints.SelectedValue
                                                     select rs).ToList();
            grdTasks.DataSource = resouoltionTasks;
            grdTasks.DataBind();
        }
        ShowTaskDescription();
    }

    protected void ShowTaskDescription()
    {
        using (ApplicationDbContext dbContext = new ApplicationDbContext())
        {
            Grievance griev = (from Grievance gr in dbContext.Grievances
                               where gr.GrievanceID.ToString() == ddlComplaints.SelectedValue
                               select gr).FirstOrDefault();
            if (griev != null)
                ltlTaskDesc.Text = griev.GrievanceDescription;
        }
    }
    protected void ddlComplaints_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindTasks();
        ShowTaskDescription();
        BindEmployees();
    }
    protected void btnCreate_Click(object sender, EventArgs e)
    {
        using (ApplicationDbContext dbContext = new ApplicationDbContext())
        {
            Grievance griev = (from Grievance gr in dbContext.Grievances
                               where gr.GrievanceID.ToString() == ddlComplaints.SelectedValue
                               select gr).FirstOrDefault();
            ResolutionTask task = new ResolutionTask()
            {
                TaskDescription = txtDescription.Text,
                TaskBudget = Convert.ToDecimal(txtBudget.Text),
                TargetStartDate = Convert.ToDateTime(txtTargetStartDate.Text),
                TargetCompletionDate = Convert.ToDateTime(txtTargetCompletionDate.Text),
                MenReqired = Convert.ToInt32(txtMenRequired.Text),
                Comments = txtComments.Text,
                Grievance = griev,
                Resolver = (from Employee emp in dbContext.Employees
                            where emp.EmployeeID.ToString() == ddlEmployee.SelectedValue
                            select emp).FirstOrDefault(),
                Status = ResolutionTask.TaskStatus.ToBeStarted
            };
            dbContext.ResolutionTasks.Add(task);
            dbContext.SaveChanges();

           List<ResolutionTask> ResTaskList = (from Grievance gr in dbContext.Grievances
                            where gr.GrievanceID.ToString() == ddlComplaints.SelectedValue
                            select gr.ResolutionTasks).FirstOrDefault().ToList();

            if (ResTaskList.Count > 0)
            {
                DateTime LatestDateForATask = ResTaskList[0].TargetCompletionDate;

                foreach (ResolutionTask restask in ResTaskList)
                {
                    if (restask.TargetCompletionDate > LatestDateForATask)
                    {
                        LatestDateForATask = restask.TargetCompletionDate;
                    }
                }
                griev.TargetCompletionDate = LatestDateForATask;
                dbContext.SaveChanges();

            }
        }

    }
}
