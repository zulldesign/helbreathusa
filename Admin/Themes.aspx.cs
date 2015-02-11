using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Themes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            BindThemes();

    }

    private void BindThemes()
    {
        DirectoryInfo rootDirectory = new DirectoryInfo(Server.MapPath("~/App_Themes"));
        InstalledThemesDropDownList.DataSource = rootDirectory.GetDirectories().Where(d => d.Name != "Default");
        InstalledThemesDropDownList.DataBind();
        ListItem currentTheme = InstalledThemesDropDownList.Items.FindByText(StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreTheme));
        if (currentTheme != null)
            currentTheme.Selected = true;
    }
    protected void InstallButton_Click(object sender, EventArgs e)
    {
        StoreConfiguration.UpdateValue(ConfigurationKey.StoreTheme, InstalledThemesDropDownList.SelectedValue);
        StoreConfigurations.UpdateConfigurationValue(ConfigurationKey.StoreTheme, InstalledThemesDropDownList.SelectedValue);
        MessageLiteral.Text = "Store Theme updated to " + InstalledThemesDropDownList.SelectedValue + ". You can view your store <a href='" + Request.Url.ToString().ToLower().Replace("admin/themes.aspx", "") + "' target='_blank'>here</a>";
    }
}