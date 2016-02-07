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
        var user = new ApplicationUser() { UserName = UserName.Text, FirstName = FirstName.Text, LastName = LastName.Text, PhoneNumber = PhoneNumber.Text, Email = Email.Text };
        IdentityResult IdUserResult = userMgr.Create(user, Password.Text);

        if (IdUserResult.Succeeded)
        {
            if (!userMgr.IsInRole(user.Id, "Complainant")) // Only users of type "Complainant" can be created from the "Register" page.
            {
                IdUserResult = userMgr.AddToRole(user.Id, "Complainant");
            }
            ApplicationDbContext dbCon = new ApplicationDbContext();
            dbCon.Complainants.Add(new Complainant(user)
            {
                Address = Address.Text,
                PinCode = Convert.ToInt64(PinCode.Text)
            });

           // dbCon.SaveChanges();
            IdentityHelper.SignIn(userMgr, user, isPersistent: false);
            IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
        }
        else
        {
            ErrorMessage.Text = IdUserResult.Errors.FirstOrDefault();
        }
    }
}