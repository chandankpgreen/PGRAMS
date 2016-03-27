using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Employee
/// </summary>
namespace PGRAMS_CS
{
    public class Employee : ApplicationUser
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long EmployeeID { get; set; }
        public Grievance.GrievanceTypes Department { get; set; }

        public Employee()
        {

        }
        public Employee(ApplicationUser AppUser)
        {
            this.UserName = AppUser.UserName;
            this.FirstName = AppUser.FirstName;
            this.LastName = AppUser.LastName;
            this.PhoneNumber = AppUser.PhoneNumber;
            this.Email = AppUser.Email;
            this.PasswordHash = AppUser.PasswordHash;
        }
    }
}