using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DatabaseContext
/// </summary>

  public class DataBaseContext : DbContext
  {
     public DataBaseContext()
          : base("DefaultConnection")
    {
    }
    public DbSet<Complainant> Complainants { get; set; }
    public DbSet<Employee> Employees { get; set; }
  }
