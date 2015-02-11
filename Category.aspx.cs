using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Cache;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Category : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MenuID = "products";

        if (!Page.IsPostBack)
        {
            InvertedSoftware.ShoppingCart.DataObjects.Category category = CacheManager.GetCachedCategory((string)RouteData.Values["CategoryName"]);
            BindProducts();
            Page.Title = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + " : " + (string.IsNullOrWhiteSpace((string)RouteData.Values["CategoryName"]) ? "All Products" : (string)RouteData.Values["CategoryName"]);
            Page.MetaDescription = (string.IsNullOrWhiteSpace((string)RouteData.Values["CategoryName"]) ? "All Products" : category.MetaDescription);
            Page.MetaKeywords = (string.IsNullOrWhiteSpace((string)RouteData.Values["CategoryName"]) ? string.Empty : category.MetaKeywords);
        }
    }

    public void BindProducts()
    {
        if (ProductsGrid == null)
            return;
        // Page number
        int pageNumber = 0;
        int.TryParse(Request.QueryString["Page"], out pageNumber);
        // Page size
        int perPage = 20;
        int.TryParse(Request.QueryString["PerPage"], out perPage);
        if (perPage == 0)
            perPage = 20;
        // Sort order
        SortOrder sortOrder = SortOrder.DontSort;
        Enum.TryParse<SortOrder>(Request.QueryString["Sort"], out sortOrder);
        
        ProductsGrid.PageNumber = pageNumber;
        ProductsGrid.PageSize = perPage;
        int totalRecords = 0;
        if (perPage == -1) // Set up infinite scroll by loading the first 100 products and making the infinite scroll div visible.
        {
            ProductsGrid.PageSize = 100;
            ProductsGrid.IsInfiniteScroll = true;
        }
        ProductsGrid.DataSource = Products.GetCategoryProducts((string)RouteData.Values["CategoryName"], pageNumber, ProductsGrid.PageSize, out totalRecords, sortOrder);
        ProductsGrid.TotalRecords = totalRecords;
        ProductsGrid.DataBind();
    }

    public IEnumerable<InvertedSoftware.ShoppingCart.DataObjects.Category> CategoryNavRepeater_GetData([RouteData("CategoryName")] string categoryName)
    {
        return CacheManager.GetCachedChildCategories(categoryName);
    }
}