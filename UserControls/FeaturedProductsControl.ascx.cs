using InvertedSoftware.ShoppingCart.DataLayer.Cache;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_FeaturedProductsControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ProductsSummaryRepeater_PreRender(object sender, EventArgs e)
    {
        if (ProductsSummaryRepeater.Items.Count == 0)
            ProductsSummaryRepeater.Visible = false;
    }

    public IEnumerable<InvertedSoftware.ShoppingCart.DataObjects.FeaturedProduct> ProductsSummaryRepeater_GetData([RouteData("CategoryName")] string categoryName)
    {
        if (string.IsNullOrWhiteSpace(categoryName)) // Return products on the main page
            return Products.GetFeaturedProducts(null);
        else
        {
            var category = CacheManager.GetCachedCategory(categoryName);
            if(category!=null)
                return Products.GetFeaturedProducts(category.CategoryID); // Return products in category
            return null;
        }
    }
}
