using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity;
using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UserRoleInitialization
/// </summary>
public class UserRoleInitialization
{

    /// <summary>
    /// Checks for the three roles - Admin, Employee and Complainant and 
    /// creates them if not present
    /// </summary>
    public static void InitializeRoles()
    {  // Access the application context and create result variables.
        ApplicationDbContext context = new ApplicationDbContext();
        IdentityResult IdUserResult;

        // Create a RoleStore object by using the ApplicationDbContext object. 
        // The RoleStore is only allowed to contain IdentityRole objects.
        var roleStore = new RoleStore<IdentityRole>(context);

        RoleManager roleMgr = new RoleManager();
        if (!roleMgr.RoleExists("Administrator"))
        {
            roleMgr.Create(new ApplicationRole { Name = "Administrator" });
        }
        if (!roleMgr.RoleExists("Employee"))
        {
            roleMgr.Create(new ApplicationRole { Name = "Employee" });
        }
        if (!roleMgr.RoleExists("Complainant"))
        {
            roleMgr.Create(new ApplicationRole { Name = "Complainant" });
        }
        if (!roleMgr.RoleExists("Auditor"))
        {
            roleMgr.Create(new ApplicationRole { Name = "Auditor" });
        }
      

        // Create a UserManager object based on the UserStore object and the ApplicationDbContext  
        // object. Note that you can create new objects and use them as parameters in
        // a single line of code, rather than using multiple lines of code, as you did
        // for the RoleManager object.
        var userMgr = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
        var appUser = new ApplicationUser
        {
            UserName = "Administrator",
            Email = "Administrator@pgrams.com"
        };
        IdUserResult = userMgr.Create(appUser, "Admin123");

        // If the new "canEdit" user was successfully created, 
        // add the "canEdit" user to the "canEdit" role. 
        if (!userMgr.IsInRole(userMgr.FindByEmail("Administrator@pgrams.com").Id, "Administrator"))
        {
            IdUserResult = userMgr.AddToRole(userMgr.FindByEmail("Administrator@pgrams.com").Id, "Administrator");
        }
         appUser = new ApplicationUser
        {
            UserName = "Auditor",
            Email = "Auditor@pgrams.com"
        };
        IdUserResult = userMgr.Create(appUser, "Auditor123");

        // If the new "canEdit" user was successfully created, 
        // add the "canEdit" user to the "canEdit" role. 
        if (!userMgr.IsInRole(userMgr.FindByEmail("Auditor@pgrams.com").Id, "Auditor"))
        {
            IdUserResult = userMgr.AddToRole(userMgr.FindByEmail("Auditor@pgrams.com").Id, "Auditor");
        }
    }


}