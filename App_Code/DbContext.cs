using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DbConnectionModel
/// </summary>
public class DatabaseContext : DbContext
{
    public DatabaseContext()
        : base("DefaultConnection")
    {
    }
   
    //public DbSet<Suggestion> Suggestions { get; set; }
    //public DbSet<Feedback> Feedbacks { get; set; }
}