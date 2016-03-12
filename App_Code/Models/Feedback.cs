using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Feedback
/// </summary>
namespace PGRAMS_CS
{
    public class Feedback
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long FeedbackID {get; set;}

        public virtual Grievance Grievance { get; set;}
        public string Comment { get; set; }
        public virtual Complainant Complainant { get; set; }
        public DateTime DateLogged { get; set; }

        public Feedback()
        {

        }
    }
}