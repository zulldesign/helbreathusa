using InvertedSoftware.ShoppingCart.BusinessLayer;
using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.DataObjects;
using InvertedSoftware.ShoppingCart.Localization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ShoppingCart : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MenuID = "cart";

        if (!Page.IsPostBack)
        {
            if (!string.IsNullOrWhiteSpace(Request.QueryString["CartID"]))
                LoadCart(Request.QueryString["CartID"]);

            BindCart();
            CartManager manager = new CartManager(this.Cart);
            bool googleCheckoutEnabled = false;
            bool.TryParse(StoreConfiguration.GetConfigurationValue(ConfigurationKey.GoogleCheckoutEnabled), out googleCheckoutEnabled);
            GoogleCheckoutControl1.Visible = (googleCheckoutEnabled && !manager.IsCartContainSubscription());
            Page.Title = "My Cart - " + StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName);
        }
    }

    public void BindCart()
    {
        MessageLiteral.Text = FormsResources.Cart;
        CartRepeater.DataSource = this.Cart.CartItems;
        CartRepeater.DataBind();
        ((Repeater)CartRepeater.Controls[CartRepeater.Controls.Count - 1].FindControl("OffersRepeater")).DataSource = this.Cart.CartCoupons;
        ((Repeater)CartRepeater.Controls[CartRepeater.Controls.Count - 1].FindControl("OffersRepeater")).DataBind();
        CartManager manager = new CartManager(this.Cart);
        this.Cart.Discounts = manager.Discounts;
        this.Cart.Subtotal = manager.SubTotal;
        this.Cart.Total = manager.Total;
        if (this.Cart.CartItems.Count == 0)
        {
            MessageLiteral.Text += FormsResources.Empty;
            CheckoutButton.Enabled = false;
            UpdateButton.Enabled = false;
        }
        else
        {
            CheckoutButton.Enabled = true;
            UpdateButton.Enabled = true;
        }
    }

    protected void CartRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        CartManager manager = new CartManager(this.Cart);
        if (e.CommandName == "AddCoupon")
        {
            TextBox OfferCodeTextBox = CartRepeater.Controls[CartRepeater.Controls.Count - 1].FindControl("OfferCodeTextBox") as TextBox;
            if (OfferCodeTextBox == null)
                return;
            Coupon coupon = Coupons.GetCoupon(OfferCodeTextBox.Text);
            if (coupon.CouponID > 0)
            {
                try
                {
                    manager.AddCoupon(coupon);
                    CouponMessageLiteral.Text = FormsResources.OfferAdded;
                }
                catch (Exception ex)
                {
                    CouponMessageLiteral.Text = ex.Message;
                }
            }
            else
                CouponMessageLiteral.Text = FormsResources.OfferNotFound;
        }
        else
            manager.Remove(e.Item.ItemIndex);
        DeleteSavedCart();
        this.Cart = manager.ShoppingCart;
        BindCart();
    }

    protected void OffersRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        CartManager manager = new CartManager(this.Cart);
        manager.RemoveCoupon(Convert.ToInt32(e.CommandArgument));
        DeleteSavedCart();
        this.Cart = manager.ShoppingCart;
        BindCart();
    }

    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        CartManager manager = new CartManager(this.Cart);
        foreach (RepeaterItem item in CartRepeater.Items)
        {
            int qty = 0;
            if (int.TryParse(((TextBox)item.FindControl("QuantityTextBox")).Text, out qty) && qty > 0)
                manager.SetQuantity(item.ItemIndex, qty);
            else
                manager.Remove(item.ItemIndex);
        }
        DeleteSavedCart();
        this.Cart = manager.ShoppingCart;
        BindCart();
    }
    protected void ContinueButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
    protected void CheckoutButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("Checkout.aspx");
    }

    public string GetProductOptions(int itemIndex)
    {
        StringBuilder sb = new StringBuilder();
        CartItem item = this.Cart.CartItems.ElementAt(itemIndex);
        foreach (ProductOption option in item.ProductOptions)
            sb.Append(option.ProductOptionName + "<br>");
        return sb.ToString();
    }

    public string GetCustomFields(int itemIndex)
    {
        StringBuilder sb = new StringBuilder();
        CartItem item = this.Cart.CartItems.ElementAt(itemIndex);
        foreach (CustomField field in item.CustomFields)
            sb.Append("<br>" + field.CustomFieldName + ": " + field.CustomFieldValue);
        return sb.ToString();
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        Profile.ShoppingCart = Cart;
        Profile.Save();
        MessageLiteral.Text = FormsResources.CartSaved;
    }

    public void DeleteSavedCart()
    {
        if (HttpContext.Current.Profile["ShoppingCart"] != null || ((Cart)HttpContext.Current.Profile["ShoppingCart"]).CartItems.Count() == 0)
        {
            Profile.ShoppingCart = new Cart();
            Profile.Save();
        }
    }

    protected void EmailButton_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;
        SaveButton_Click(sender, e);
        string cartID = GetLoggedUserName();
        if (string.IsNullOrEmpty(cartID))
            cartID = Request.AnonymousID;

        string cartLink = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreURL) + "/ShoppingCart.aspx?CartID=" + cartID;

        try
        {
            EmailManager.EmailCart(cartLink, EmailTextBox.Text);
            MessageLiteral.Text = "Your cart has been emailed";
        }
        catch (Exception ex)
        {
            MessageLiteral.Text = ex.Message;
        }
    }

    public void LoadCart(string cartID)
    {
        ProfileCommon savedProfile = Profile.GetProfile(cartID);
        if (savedProfile != null)
        {
            Cart = savedProfile.ShoppingCart;
            Cart.CartCoupons.RemoveWhere(c => c.ExpirationDate.HasValue && c.ExpirationDate.Value.CompareTo(DateTime.Now) > 0);
        }

    }
}