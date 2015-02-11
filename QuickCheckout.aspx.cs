using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using InvertedSoftware.ShoppingCart.Common;

public partial class QuickCheckout : System.Web.UI.Page
{
    int productID = 0;

    protected override void OnPreInit(EventArgs e)
    {
        this.Theme = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreTheme);
        base.OnPreInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        int.TryParse(Request.QueryString["ProductID"], out productID);
        if (productID == 0)
            return;
        if (RelatedProductsControl1 != null)
        {
            RelatedProductsControl1.ProductID = productID.ToString();
            RelatedProductsControl1.DataBind();
        }
    }
}