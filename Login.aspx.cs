using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + " : Login.";
    }
}