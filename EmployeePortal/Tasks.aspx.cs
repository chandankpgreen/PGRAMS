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
        if (!Page.IsPostBack){

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
            grdTasks.DataSource = (from ResolutionTask task in DbContext.ResolutionTasks
                                   where task.Resolver.Id == LoggedInUserID
                                   && InEmployee.Contains((int)task.Status)
                                   && task.Status == (ResolutionTask.TaskStatus)(Convert.ToInt16(ddlResolutionStatus.SelectedValue))
                                   select task).ToList();
            grdTasks.DataBind();
        }
    }
}