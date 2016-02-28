using Microsoft.Owin;
using Owin;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Entity;

[assembly: OwinStartupAttribute(typeof(PGRAMS_CS.Startup))]
namespace PGRAMS_CS
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }

    public static class EnumExtensionMethods
    {
        public static string GetDescription(this Enum enumValue)
        {
            object[] attr = enumValue.GetType().GetField(enumValue.ToString())
                .GetCustomAttributes(typeof(DescriptionAttribute), false);

            return attr.Length > 0
               ? ((DescriptionAttribute)attr[0]).Description
               : enumValue.ToString();
        }

        public static T ParseEnum<T>(this string stringVal)
        {
            return (T)Enum.Parse(typeof(T), stringVal);
        }
        public static List<string> GetGrievanceDescriptions()
        {
            var enumvalarray = Enum.GetValues(typeof(Grievance.GrievanceTypes));
            List<string> descriptionarray = new List<string>();
            foreach (Grievance.GrievanceTypes item in enumvalarray)
            {
                descriptionarray.Add(item.GetDescription());
            }
            return descriptionarray;
        }
    }

}
