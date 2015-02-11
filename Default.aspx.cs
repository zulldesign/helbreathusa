using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MenuID = "home";
        //If store is not configurated, show configuration screen
        if (!Utils.IS_CONFIGURED && StoreConfiguration.GetConfigurationValue(ConfigurationKey.SetupRan) == "true")
            Utils.IS_CONFIGURED = true;
        else if (!Utils.IS_CONFIGURED)
            Response.Redirect("Setup/Default.aspx");
        if (!Page.IsPostBack)
            Page.Title = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName);
    }
}