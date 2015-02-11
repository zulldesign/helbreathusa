using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using InvertedSoftware.ShoppingCart.DataLayer.Cache;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.DataObjects;

public partial class UserControls_ProductBreadcrumbControl : System.Web.UI.UserControl
{
    public List<Category> GetParentCategories(int categoryID)
    {
        if (categoryID == 0)
            return null;
        List<Category> categoryPath = new List<Category>();
        LoadParentCategories(categoryID, ref categoryPath);
        return categoryPath;
    }

    private void LoadParentCategories(int categoryID, ref List<Category> categoryPath)
    {
        var category = CacheManager.GetCachedCategories().FirstOrDefault(c => c.CategoryID == categoryID);
        if (category.ParentCategoryID.HasValue)
            LoadParentCategories(category.ParentCategoryID.Value, ref categoryPath);
        categoryPath.Add(category);
    }

    public int ProductID { get; set; }

    public System.Collections.IEnumerable BreadcrumbRepeater_GetData()
    {
        return Categories.GetProductCategories(ProductID);
    }
}