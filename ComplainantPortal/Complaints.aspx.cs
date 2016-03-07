using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using System.ComponentModel;
using System.IO;

public partial class ComplainantPortal_Complaints : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        foreach(Grievance.GrievanceTypes value in Enum.GetValues( typeof(Grievance.GrievanceTypes))){
            ddlComplaintType.Items.Add(new ListItem(value.GetDescription(), ((int)value).ToString()));
        }
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
                using (ApplicationDbContext DbContext = new ApplicationDbContext())
                {
                    Complainant LoggedInComplainant =  DbContext.Complainants.ToList().Where(x=>(x.Id ==User.Identity.GetUserId())).FirstOrDefault() ;
                    Grievance newGrievance = new Grievance()
                    {
                        GrievanceDescription = txtComplaintDescription.Text,
                        DateLogged = DateTime.Now,
                        Comments = txtComments.Text,
                        GrievanceType = (Grievance.GrievanceTypes)Convert.ToInt16(ddlComplaintType.SelectedValue),
                        ResolutionStatus = Grievance.ResolutionStatuses.Created,
                        Complainant = LoggedInComplainant
                    };
                   
                    DbContext.Grievances.Add(newGrievance);
                    DbContext.SaveChanges();

                     if (fuComplaintPic.HasFile){
                         string picturename = newGrievance.GrievanceID.ToString() +  Path.GetExtension(fuComplaintPic.PostedFile.FileName);
                         newGrievance.Picture = picturename;
                         fuComplaintPic.PostedFile.SaveAs(Path.Combine(path, picturename));
                         DbContext.SaveChanges();
                    }
                }
                
                
                Response.Redirect("TrackComplaints.aspx?Result=Success");

            }
            catch (Exception ex)
            {
                ErrorMessage.Text = ex.Message;
                ErrorPlaceHolder.Visible = true;
                return;
            }
        }
        else
        {
            ErrorMessage.Text = "Unable to accept file type.";
            ErrorPlaceHolder.Visible = true;
        }
    }
}
