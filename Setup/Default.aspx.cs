using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Setup_Default : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (StoreConfiguration.GetConfigurationValue(ConfigurationKey.SetupRan) == "true")
        {
            Utils.IS_CONFIGURED = true;
            Response.Redirect("../Default.aspx");
        }
    }

    protected void CreateUserWizard1_CreatingUser(object sender, LoginCancelEventArgs e)
    {

    }
    protected void CreateUserWizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {

    }
    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        //Create all of the roles if they dont exist and add the user to SuperAdmin group
        if (!Roles.RoleExists("SuperAdmin"))
            Roles.CreateRole("SuperAdmin");
        if (!Roles.RoleExists("Admin"))
            Roles.CreateRole("Admin");
        if (!Roles.RoleExists("Customer"))
            Roles.CreateRole("Customer");

        Roles.AddUserToRole(CreateUserWizard1.UserName, "SuperAdmin");

        StoreConfiguration.UpdateValue(ConfigurationKey.SetupRan, "true");
        StoreConfigurations.UpdateConfigurationValue(ConfigurationKey.SetupRan, "true");
        Response.Redirect("../admin/Settings.aspx?User=" + CreateUserWizard1.UserName);
       
    }
}