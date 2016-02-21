using PGRAMS_CS;
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
     

  }
