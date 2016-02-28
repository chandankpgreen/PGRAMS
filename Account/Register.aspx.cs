using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.UI;
using PGRAMS_CS;
using Microsoft.AspNet.Identity.EntityFramework;

public partial class Account_Register : Page
{
    protected void CreateUser_Click(object sender, EventArgs e)
    {
        // Create a UserManager object based on the UserStore object and the ApplicationDbContext  
        // object. 
       
        var userMgr = new UserManager();
        var complainant = new Complainant()
        {
            UserName = UserName.Text,
            FirstName = FirstName.Text,
            LastName = LastName.Text,
            PhoneNumber = PhoneNumber.Text,
            Email = Email.Text,
            Address = Address.Text,
            PinCode = Convert.ToInt64(PinCode.Text)
        };
        IdentityResult IdUserResult = userMgr.Create(complainant, Password.Text);

        UserRoleInitialization.InitializeRoles();

        if (IdUserResult.Succeeded)
        {
            if (!userMgr.IsInRole(complainant.Id, "Complainant")) // Only users of type "Complainant" can be created from the "Register" page.
            {
                IdUserResult = userMgr.AddToRole(complainant.Id, "Complainant");
            }
            
            IdentityHelper.SignIn(userMgr, complainant, isPersistent: false);
            IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
        }
        else
        {
            ErrorMessage.Text = IdUserResult.Errors.FirstOrDefault();
            ErrorPlaceHolder.Visible = true;
        }
    }
}