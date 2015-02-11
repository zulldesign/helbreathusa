using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using InvertedSoftware.ShoppingCart.DataObjects;
using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;

public partial class UserControls_CartSummaryControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bindControls();
    }

    public void bindControls()
    {


    }

    public IEnumerable<InvertedSoftware.ShoppingCart.DataObjects.CartItem> CartSummaryRepeater_GetData()
    {
        Cart cart = ((BasePage)this.Page).Cart;
        if (cart == null)
            return null;

        CartSummaryRepeater.Visible = true;
        return cart.CartItems;
    }
}
