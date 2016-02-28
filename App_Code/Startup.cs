using Microsoft.Owin;
using Owin;
using System;
using System.ComponentModel;

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
    }
}
