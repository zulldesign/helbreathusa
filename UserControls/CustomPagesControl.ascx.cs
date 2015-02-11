using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.DataLayer.Cache;

public partial class UserControls_CustomPagesControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    public MenuType MenuType { get; set; }

    public System.Collections.IEnumerable NavRepeater_GetData()
    {
        return CacheManager.GetMenuCustomPages(MenuType);
    }
}