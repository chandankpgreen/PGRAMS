using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using System.Web.UI.WebControls;

public partial class ComplainantPortal_Suggestions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindRepeater();
            foreach (Grievance.GrievanceTypes value in Enum.GetValues(typeof(Grievance.GrievanceTypes)))
            {
                ddlComplaintType.Items.Add(new ListItem(value.GetDescription(), ((int)value).ToString()));
            }
        }
    }

    protected void btnRegisterComplaint_Click(object sender, EventArgs e)
    {

        using (ApplicationDbContext DbContext = new ApplicationDbContext())
        {
            Complainant LoggedInComplainant = DbContext.Complainants.ToList().Where(x => (x.Id == User.Identity.GetUserId())).FirstOrDefault();

            Suggestion suggestion = new Suggestion()
            {
                Department = (Grievance.GrievanceTypes)Convert.ToInt16(ddlComplaintType.SelectedValue),
                Description = txtComplaintDescription.Text,
                Complainant = LoggedInComplainant,
                DateLogged = DateTime.Now
            };

            DbContext.Suggestions.Add(suggestion);
            DbContext.SaveChanges();

            BindRepeater();

            SuccessMessage.Text = "Your suggestion has been recorded.";
            SuccessPlaceHolder.Visible = true;
        }
    }
    protected void BindRepeater()
    {
        using (ApplicationDbContext DbContext = new ApplicationDbContext())
        {
            Complainant LoggedInComplainant = DbContext.Complainants.ToList().Where(x => (x.Id == User.Identity.GetUserId())).FirstOrDefault();
            rptSuggestions.DataSource = (from Suggestion sugg in DbContext.Suggestions
                                         where sugg.Complainant.Id == LoggedInComplainant.Id
                                         select sugg).ToList();
            rptSuggestions.DataBind();

        }
    }
}