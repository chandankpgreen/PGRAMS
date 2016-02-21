﻿using PGRAMS_CS;
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
        public long GrievanceID { get; set; }

        public GrievanceTypes GrievanceType { get; set; }
        public string GrievanceDescription { get; set; }
        public DateTime DateLogged { get; set; }
        public DateTime? TargetCompletionDate { get; set; } 
        public ResolutionStatuses ResolutionStatus { get; set; }
        public virtual Complainant Complainant { get; set; }
        public string Comments { get; set; }
        public string Picture { get; set; }
        public virtual ICollection<ResolutionTask> ResolutionTasks { get; set; }
      

        public Grievance()
        {

        }
        public enum GrievanceTypes
        {
            [Description("Electrity/Street Lighting")]
            Electricity = 1,

            [Description("Water Supply/Plumbing")]
            Water = 2,

            [Description("Sewage/Waste Management/Disposal")]
            Waste = 3,

            [Description("Cooking Gas Connection/Leakage")]
            Gas = 4,

            [Description("Roads/Streets")]
            Road = 5,

            [Description("Cleanliness")]
            Cleanliness = 6,

            [Description("Conveninece")]
            Convenience = 7,

            [Description("Others")]
            Others = 8
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