using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindProducts();
            Page.Title = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + " : " + Request["Keyword"];
            Page.MetaKeywords = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + ",Search,Products," + Request["Keyword"];
            Page.MetaDescription = "Search for products in " + StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + " " + Request["Keyword"];
        }
    }

    public void BindProducts()
    {
        int totalResults = 0;
        int pageNumber = 0;
        int.TryParse(Request["Page"], out pageNumber);
       
        string keyword = Request["Keyword"];
        string tag = Request["Tag"];
        if (string.IsNullOrWhiteSpace(keyword) && string.IsNullOrWhiteSpace(tag))
            Response.Redirect("Default.aspx");

        ProductsGrid.PageNumber = pageNumber;
        ProductsGrid.PageSize = 18;
        if (!string.IsNullOrWhiteSpace(keyword))
            ProductsGrid.DataSource = Products.SearchProducts(keyword, pageNumber, ProductsGrid.PageSize, out totalResults);
        else if (!string.IsNullOrWhiteSpace(tag))
            ProductsGrid.DataSource = Products.GetProductsByTags(tag, pageNumber, ProductsGrid.PageSize, out totalResults);
        ProductsGrid.TotalRecords = totalResults;
        ProductsGrid.DataBind();
    }
}