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
    {
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
    }


}