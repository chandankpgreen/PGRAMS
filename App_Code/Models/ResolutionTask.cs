using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ResolutionTask
/// </summary>
namespace PGRAMS_CS
{
    public class ResolutionTask
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long TaskID { get; set; }

        public string TaskDescription { get; set; }
        // ID of the employee to which this is assigned
        public virtual Employee Resolver { get; set; }
        public decimal TaskBudget { get; set; }
        public int MenReqired { get; set; }
        public DateTime TargetStartDate { get; set; }
        public DateTime TargetCompletionDate { get; set; }
        public DateTime? ActualCompletionDate { get; set; }
        public string Comments { get; set; }
        public virtual Grievance Grievance { get; set; }
        public TaskStatus Status { get; set; }

        public ResolutionTask()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public enum TaskStatus
        {
            [Description("To be started")]
            ToBeStarted = 0,

            [Description("Started")]
            Started = 1,

            [Description("In Progress")]
            InProgress = 2,

            [Description("Completed")]
            Completed = 3
        }
    }
}