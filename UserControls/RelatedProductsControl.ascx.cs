using InvertedSoftware.ShoppingCart.DataLayer.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_RelatedProductsControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LimitTotal = 8;
    }

    public string ProductID { get; set; }
    public int LimitTotal { get; set; }

    protected void ProductsSummaryRepeater_PreRender(object sender, EventArgs e)
    {
        if (ProductsSummaryRepeater.Items.Count == 0)
            ProductsSummaryRepeater.Visible = false;
    }

    public IEnumerable<InvertedSoftware.ShoppingCart.DataObjects.RelatedProduct> ProductsSummaryRepeater_GetData()
    {
        return Products.GetRelatedProducts(int.Parse(ProductID)).Take(LimitTotal);
    }
}
