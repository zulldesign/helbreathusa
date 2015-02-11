using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Site : System.Web.UI.MasterPage {

    protected void Page_Load(object sender, System.EventArgs e)
    {
        //RegisterScripts();
    }

    private void RegisterScripts()
    {
        if (ScriptManager.ScriptResourceMapping.GetDefinition("jquery") == null)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/Scripts/jquery-1.7.1.min.js",
                DebugPath = "~/Scripts/jquery-1.7.1.js",
                CdnPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.1.min.js",
                CdnDebugPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.1.js",
                CdnSupportsSecureConnection = true,
                LoadSuccessExpression = "window.jQuery"
            });
        }
    }
}
