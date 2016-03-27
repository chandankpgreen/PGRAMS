using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using PGRAMS_CS;

public partial class EmployeePortal_Tasks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            GetTasks();
        }

    }
    protected void ddlResolutionStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetTasks();
    }
    protected void GetTasks()
    {
        int[] InEmployee = { 0, 1, 2 };
        using (ApplicationDbContext DbContext = new ApplicationDbContext())
        {
            string LoggedInUserID = User.Identity.GetUserId();
            ResolutionTask.TaskStatus selectedTaskStatus = (ResolutionTask.TaskStatus)(Convert.ToInt16(ddlResolutionStatus.SelectedValue));
            grdTasks.DataSource = (from ResolutionTask task in DbContext.ResolutionTasks
                                   where task.Resolver.Id == LoggedInUserID
                                   && InEmployee.Contains((int)task.Status)
                                   && task.Status == selectedTaskStatus
                                   select task).ToList();
            grdTasks.DataBind();
        }
    }
    protected void grdTasks_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ResolutionTask.TaskStatus val = (ResolutionTask.TaskStatus)Enum.Parse(typeof(ResolutionTask.TaskStatus), e.Row.Cells[8].Text);
            e.Row.Cells[8].Text = val.GetDescription();
        }
    }
    protected void btnCompleteConfirm_Click(object sender, EventArgs e)
    {
        ApplicationDbContext dbContext = new ApplicationDbContext();
        string LoggedInUserID = User.Identity.GetUserId();
        List<ResolutionTask> ResolutionTasks = (from ResolutionTask tk in dbContext.ResolutionTasks
                                                where tk.Resolver.Id == LoggedInUserID
                                                orderby tk.TaskID ascending
                                                select tk).ToList();

        List<ResolutionTask> CheckedTaskList = new List<ResolutionTask>();
        foreach (GridViewRow row in grdTasks.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("ckbSelectTask");

            if (chk.Checked)
            {
                foreach (ResolutionTask tk in ResolutionTasks)
                {
                    long checkedTaskID = Convert.ToInt64(row.Cells[1].Text);
                    if (tk.TaskID == checkedTaskID)
                    {
                        tk.Status = ResolutionTask.TaskStatus.Completed;
                        tk.ActualCompletionDate = DateTime.Now;
                        CheckedTaskList.Add(tk);
                    }
                }
            }
        }
        try
        {
            dbContext.SaveChanges();
            GetTasks();
            CheckGrievanceStatus(CheckedTaskList);
            ErrorPlaceHolder.Visible = false;
            SuccessMessage.Text = "Selected task(s) have been marked as Completed.";
            SuccessPlaceHolder.Visible = true;
        }
        catch (Exception ex)
        {
            ErrorMessage.Text = ex.Message;
            ErrorPlaceHolder.Visible = true;
        }
    }
    protected void CheckGrievanceStatus(List<ResolutionTask> tklist)
    {
        try
        {
            using (ApplicationDbContext DbContext = new ApplicationDbContext())
            {
                List<Grievance> grievancelist = new List<Grievance>();
                foreach (ResolutionTask tk in tklist)
                {
                    grievancelist = (from Grievance gr in DbContext.Grievances
                                     where gr.ResolutionTasks.Contains(tk)
                                     select gr).ToList();
                }
                foreach (Grievance gr in grievancelist)
                {
                    List<ResolutionTask> TaskList = (from ResolutionTask tk in gr.ResolutionTasks
                                                     where tk.Status != ResolutionTask.TaskStatus.Completed
                                                     select tk).ToList();
                    if (TaskList.Count == 0)
                    {
                        gr.ResolutionStatus = Grievance.ResolutionStatuses.Completed;
                    }
                }
                DbContext.SaveChanges();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.Text = ex.Message;
            ErrorPlaceHolder.Visible = true;
        }
    }
    protected void btnInProgressConfirm_Click(object sender, EventArgs e)
    {
        ApplicationDbContext dbContext = new ApplicationDbContext();
        string LoggedInUserID = User.Identity.GetUserId();
        List<ResolutionTask> ResolutionTasks = (from ResolutionTask tk in dbContext.ResolutionTasks
                                                where tk.Resolver.Id == LoggedInUserID
                                                orderby tk.TaskID ascending
                                                select tk).ToList();

        foreach (GridViewRow row in grdTasks.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("ckbSelectTask");

            if (chk.Checked)
            {
                foreach (ResolutionTask tk in ResolutionTasks)
                {
                    long checkedTaskID = Convert.ToInt64(row.Cells[1].Text);
                    if (tk.TaskID == checkedTaskID)
                    {
                        tk.Status = ResolutionTask.TaskStatus.InProgress;
                    }
                }
            }
        }
        try
        {
            dbContext.SaveChanges();
            GetTasks();
            ErrorPlaceHolder.Visible = false;
            SuccessMessage.Text = "Selected task(s) have been marked as in Progress.";
            SuccessPlaceHolder.Visible = true;
        }
        catch (Exception ex)
        {
            ErrorMessage.Text = ex.Message;
            ErrorPlaceHolder.Visible = true;
        }
    }
    protected void btnStartConfirm_Click(object sender, EventArgs e)
    {
        ApplicationDbContext dbContext = new ApplicationDbContext();
        string LoggedInUserID = User.Identity.GetUserId();
        List<ResolutionTask> ResolutionTasks = (from ResolutionTask tk in dbContext.ResolutionTasks
                                                where tk.Resolver.Id == LoggedInUserID
                                                orderby tk.TaskID ascending
                                                select tk).ToList();

        foreach (GridViewRow row in grdTasks.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("ckbSelectTask");

            if (chk.Checked)
            {
                foreach (ResolutionTask tk in ResolutionTasks)
                {
                    long checkedTaskID = Convert.ToInt64(row.Cells[1].Text);
                    if (tk.TaskID == checkedTaskID)
                    {
                        tk.Status = ResolutionTask.TaskStatus.Started;
                    }
                }
            }
        }
        try
        {
            dbContext.SaveChanges();
            GetTasks();
            ErrorPlaceHolder.Visible = false;
            SuccessMessage.Text = "Selected task(s) have been marked as Started.";
            SuccessPlaceHolder.Visible = true;
        }
        catch (Exception ex)
        {
            ErrorMessage.Text = ex.Message;
            ErrorPlaceHolder.Visible = true;
        }
    }
}