using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

public partial class ComplainantPortal_Complaints : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //using (ApplicationDbContext DbContext = new ApplicationDbContext())
        //{
        //    string LoggedInUserID = User.Identity.GetUserId();
        //    grdComplaints.DataSource = (from grievance in DbContext.Grievances
        //                                where grievance.Complainant.Id == LoggedInUserID
        //                                select grievance).ToList();
        //    grdComplaints.DataBind();
        //}

    }
 
    protected void btnRegisterComplaint_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath("~/Content/Grievances/Images");
        Boolean fileOK = true;
        if (fuComplaintPic.HasFile)
        {
            fileOK = false;
            String fileExtension = System.IO.Path.GetExtension(fuComplaintPic.FileName).ToLower();
            String[] allowedExtensions = { ".gif", ".png", ".jpeg", ".jpg" };
            for (int i = 0; i < allowedExtensions.Length; i++)
            {
                if (fileExtension == allowedExtensions[i])
                {
                    fileOK = true;
                }
            }
        }

        if (fileOK)
        {
            try
            {
                // Save to Images/Thumbs folder.
                string FilePathOnServer = fuComplaintPic.HasFile ? path + fuComplaintPic.FileName : string.Empty;
                fuComplaintPic.PostedFile.SaveAs(FilePathOnServer);
                Grievance newGrievance = new Grievance()
                {
                    GrievanceDescription = txtComplaintDescription.Text,
                    DateLogged = DateTime.Now,
                    Comments = txtComments.Text,
                    GrievanceType = (Grievance.GrievanceTypes)Convert.ToInt16(ddlComplaintType.SelectedValue),
                    ResolutionStatus = Grievance.ResolutionStatuses.Started,
                    Picture = FilePathOnServer
                };
                using (ApplicationDbContext DbContext = new ApplicationDbContext())
                {
                    DbContext.Grievances.Add(newGrievance);
                    DbContext.SaveChanges();
                }

            }
            catch (Exception ex)
            {
                ErrorMessage.Text = ex.Message;
                return;
            }
        }
        else
        {
            ErrorMessage.Text = "Unable to accept file type.";
        }
    }
}