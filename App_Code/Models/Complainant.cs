using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Complainant
/// </summary>
public class Complainant : ApplicationUser
{
    public string Address { get; set; }
    public long PinCode { get; set; }
    public virtual ICollection<Grievance> Greivances { get; set; }

    public Complainant()
    {

    }
    public Complainant(ApplicationUser AppUser)
    {
        this.UserName = AppUser.UserName;
        this.FirstName = AppUser.FirstName;
        this.LastName = AppUser.LastName;
        this.PhoneNumber = AppUser.PhoneNumber;
        this.Email = AppUser.Email;
        this.PasswordHash = AppUser.PasswordHash;
    }
}