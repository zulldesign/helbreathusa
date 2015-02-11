using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Cache;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class NewsItem : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MenuID = "news";
        Page.Title = CurrentNewsItem.NewsItemName + " : " + StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName);
        Page.MetaDescription = CurrentNewsItem.NewsItemName;
    }

    private InvertedSoftware.ShoppingCart.DataObjects.NewsItem currentNewsItem = null;

    public InvertedSoftware.ShoppingCart.DataObjects.NewsItem CurrentNewsItem
    {
        get
        {
            if (currentNewsItem == null)
            {
                string newsItemName = Convert.ToString(RouteData.Values["Newsitem"]);
                currentNewsItem = CacheManager.GetNewsItem(newsItemName);
            }
            return currentNewsItem;
        }
    }
}