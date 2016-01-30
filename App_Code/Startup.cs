using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PGRAMS_CS.Startup))]
namespace PGRAMS_CS
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
