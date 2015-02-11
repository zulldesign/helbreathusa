using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Cache;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomPage : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = CartPage.CustomPageName + " : " + StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName);
        this.MetaKeywords = CartPage.MetaTagKeywords;
        this.MetaDescription = CartPage.MetaTagDescription;
    }

    private InvertedSoftware.ShoppingCart.DataObjects.CustomPage cartPage = null;

    public InvertedSoftware.ShoppingCart.DataObjects.CustomPage CartPage
    {
        get
        {
            if (cartPage == null)
            {
                string pageName = (string)Page.RouteData.Values["PageName"];
                if (!string.IsNullOrWhiteSpace(pageName))
                    cartPage = CacheManager.GetCustomPage(pageName);
                else
                    Response.Redirect("~/");
            }
            return cartPage;
        }
    }
}