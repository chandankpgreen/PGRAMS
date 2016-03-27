using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

public partial class AdministratorPortal_RegisterEmployee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        foreach (Grievance.GrievanceTypes value in Enum.GetValues(typeof(Grievance.GrievanceTypes)))
        {
            Department.Items.Add(new ListItem(value.GetDescription(), ((int)value).ToString()));
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        var userMgr = new UserManager();

        var employee = new Employee()
        {
            UserName = UserName.Text,
            FirstName = FirstName.Text,
            LastName = LastName.Text,
            PhoneNumber = PhoneNumber.Text,
            Email = Email.Text,
            Department = (Grievance.GrievanceTypes)Convert.ToInt32(Department.SelectedValue)
        };
        IdentityResult IdUserResult = userMgr.Create(employee, Password.Text);

        if (IdUserResult.Succeeded)
        {
            if (!userMgr.IsInRole(employee.Id, "Employee")) // Only users of type "Employee" can be created from the "Register Employee" page.
            {
                IdUserResult = userMgr.AddToRole(employee.Id, "Employee");
            }
            SuccessMessage.Text = "Employee created successfully";
            SuccessMessage.Visible = true;
            ErrorMessage.Visible = false;

            FirstName.Text = LastName.Text = PhoneNumber.Text = Email.Text = Password.Text = ConfirmPassword.Text = string.Empty;
        }
        else
        {
            ErrorMessage.Text = IdUserResult.Errors.FirstOrDefault();
            ErrorMessage.Visible = true;
            SuccessMessage.Visible = false;
        }
        
    }
}