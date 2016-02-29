using PGRAMS_CS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace PGRAMS_CS
{

    /// <summary>
    /// Summary description for Grievance
    /// </summary>
    public class Grievance
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [DisplayName("Complaint ID")]
        public long GrievanceID { get; set; }

        [DisplayName("Complaint Type")]
        public GrievanceTypes GrievanceType { get; set; }

        [DisplayName("Complaint Description")]
        public string GrievanceDescription { get; set; }

        [DisplayName("Date of Logging")]
        public DateTime DateLogged { get; set; }

        [DisplayName("Target Completion Date")]
        public DateTime? TargetCompletionDate { get; set; }

        [DisplayName("Status")]
        public ResolutionStatuses ResolutionStatus { get; set; }

        public virtual Complainant Complainant { get; set; }

        [DisplayName("Comments")]
        public string Comments { get; set; }

        public string Picture { get; set; }
        public virtual ICollection<ResolutionTask> ResolutionTasks { get; set; }
      

        public Grievance()
        {

        }
        public enum GrievanceTypes
        {
            [Description("Electrity/Street Lighting")]
            Electricity = 4,

            [Description("Water Supply/Plumbing")]
            Water = 8,

            [Description("Sewage/Waste Management/Disposal")]
            Waste = 6,

            [Description("Cooking Gas Connection/Leakage")]
            Gas = 3,

            [Description("Roads/Streets")]
            Road = 5,

            [Description("Cleanliness")]
            Cleanliness = 1,

            [Description("Conveninece")]
            Convenience = 2,

            [Description("Others")]
            Others = 7
        }

        public enum ResolutionStatuses
        {
            [Description("Created")]
            Created = 1,

            [Description("In Review")]
            InReview = 2,

            [Description("Surveyed")]
            Surveyed = 3,

            [Description("Approved")]
            Approved = 4,

            [Description("Rejected(No need to Address)")]
            Rejected = 5,

            [Description("Cancelled(For lack of funds/inventory/manpower etc.)")]
            Cancelled = 6,

            [Description("Started working on the Complaint")]
            Started = 7,

            [Description("Complaint Resolution in Progress")]
            InProgress = 8,

            [Description("Completed implementation")]
            Completed = 9,

            [Description("Verified Status of Completion")]
            Verified = 10,

            [Description("Complainant Unsatisfied/Shoddy work")]
            Reopened = 11,

            [Description("Did not address in time/Ignored")]
            Flagged = 12,

            [Description("On Hold")]
            OnHold = 13
        }
    }
}
