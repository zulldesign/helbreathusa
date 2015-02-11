using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using InvertedSoftware.ShoppingCart.DataLayer.Cache;
using InvertedSoftware.ShoppingCart.DataObjects;
using InvertedSoftware.ShoppingCart.DataLayer.Database;

public partial class UserControls_MenuControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    public IEnumerable<InvertedSoftware.ShoppingCart.DataObjects.Category> CategoryRepeater_GetData()
    {
        return CacheManager.GetCachedCategories().Where(c => !c.ParentCategoryID.HasValue);
    }

    public bool isNewsMenuItemVisible()
    {
        return CacheManager.GetNewsItemsCount() > 0;
    }
}
