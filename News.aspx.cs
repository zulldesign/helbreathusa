using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class News : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MenuID = "news";
        Page.Title = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + " : News.";
        Page.MetaDescription = "Read " + StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + " News.";
        Page.MetaKeywords = "News";
    }

    public IEnumerable<InvertedSoftware.ShoppingCart.DataObjects.NewsItem> NewsRepeater_GetData([QueryString("Page")] string Page)
    {
        int pageNumber = 0;
        int.TryParse(Page, out pageNumber);

        PageNumber = pageNumber;
        PageSize = 5;
        int totalRecords = 0;
        var newsItems = NewsItems.GetNewsItems(pageNumber, PageSize, out totalRecords);
        TotalRecords = totalRecords;
        if (PageCount > 1)
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "NumericPaging", "showPager(" + PageNumber + ", " + PageSize + ", " + TotalRecords + ", " + PageCount + ");", true);
        return newsItems;
    }

    #region Navigation Properties
    public int TotalRecords { get; set; }
    public int PageNumber { get; set; }
    public int PageSize { get; set; }

    public int PageCount
    {
        get
        {
            if (TotalRecords <= 0 || PageSize <= 0)
                return 1;
            else
                return ((TotalRecords + PageSize) - 1) / PageSize;
        }
    }
    #endregion
}