using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Suggestion
/// </summary>
namespace PGRAMS_CS
{
    public class Suggestion
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long SuggestionID {get; set;}

        public virtual Complainant Complainant { get; set; }
        public Grievance.GrievanceTypes Department { get; set; }
        public string Description { get; set; }
        public DateTime DateLogged { get; set; }

        public Suggestion()
        {

        }
    }
}