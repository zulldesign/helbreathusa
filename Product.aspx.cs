using InvertedSoftware.ShoppingCart.BusinessLayer;
using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Cache;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.DataObjects;
using InvertedSoftware.ShoppingCart.Localization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Product : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (RelatedProductsControl1 != null)
            RelatedProductsControl1.ProductID = CartProduct.ProductID.ToString();
        ProductOptionsControl1.ProductID = CartProduct.ProductID;
        CustomFieldsControl1.ProductID = CartProduct.ProductID;
        if (CartProduct.IsReviewEnabled)
            ProductReviewsControl1.ProductID = CartProduct.ProductID;
        if (ProductBreadcrumbControl1 != null)
            ProductBreadcrumbControl1.ProductID = CartProduct.ProductID;
        if (!Page.IsPostBack)
        {
            Page.Title = CartProduct.ProductName + " - " + StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName);
            Page.MetaDescription = CartProduct.Description.Substring(0, (CartProduct.Description.Length >= 50) ? 50 : CartProduct.Description.Length);
            Page.MetaKeywords = CartProduct.ProductName + "," + CartProduct.Description.Substring(0, (CartProduct.Description.Length >= 50) ? 50 : CartProduct.Description.Length).Replace(" ", ",");
            CheckProductInventory();
        }
    }

    InvertedSoftware.ShoppingCart.DataObjects.Product cartProduct;

    public InvertedSoftware.ShoppingCart.DataObjects.Product CartProduct
    {
        get
        {
            if (cartProduct == null)
            {
                string productName = Page.RouteData.Values["ProductName"] as string;

                if (!string.IsNullOrEmpty(productName))
                {
                    cartProduct = Products.GetProduct(productName);
                }
            }
            if (cartProduct == null || cartProduct.ProductID == 0)
                Response.Redirect("~/Default.aspx");

            return cartProduct;
        }
        set
        {
            cartProduct = value;
        }
    }

    private List<string> productImages = null;

    public List<string> ProductImages
    {
        get
        {
            if (productImages == null)
            {
                productImages = Products.GetProductImages(CartProduct.ProductID, ImageType.Thumb75);
            }
            return productImages;
        }
    }

    protected void AddButton_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrWhiteSpace(CartProduct.ProductLink))
        {
            Response.Redirect(CartProduct.ProductLink);
            return;
        }
        if (!Page.IsValid)
            return;
        DeleteSavedCart();
        if (!AddToGiftRegistry())
            return;
        if (!CanAddSubscription())
            return;
        CartManager manager = new CartManager(this.Cart);
        int giftRegistryProductID = 0;
        int.TryParse(Request["GiftRegistryProductID"], out giftRegistryProductID);

        manager.Add(new CartItem()
        {
            CatalogNumber = CartProduct.CatalogNumber,
            PricePerUnit = CartProduct.SalePrice == 0 ? CartProduct.Price : CartProduct.SalePrice,
            ProductID = CartProduct.ProductID,
            GiftRegistryProductID = giftRegistryProductID,
            ProductName = CartProduct.ProductName,
            IsSubscription = CartProduct.IsSubscription,
            SubscriptionSetupFee = CartProduct.SubscriptionSetupFee,
            IsDownloadable = CartProduct.IsDownloadable,
            DownloadURL = CartProduct.DownloadURL,
            IsDownloadKeyRequired = CartProduct.IsDownloadKeyRequired,
            IsDownloadKeyUnique = CartProduct.IsDownloadKeyUnique,
            Quantity = Convert.ToInt32(QtyTextBox.Text),
            ProductOptions = ProductOptionsControl1.SelectedOptions,
            CustomFields = CustomFieldsControl1.CustomFields
        });
        this.Cart = manager.ShoppingCart;
        Response.Redirect("~/ShoppingCart.aspx");
    }

    private bool AddToGiftRegistry()
    {
        // Check if there is another gift registry in this cart.
        int giftRegistryProductID = 0;
        int.TryParse(Request["GiftRegistryProductID"], out giftRegistryProductID);

        if (giftRegistryProductID > 0)
        {
            if (this.Cart.GiftRegistryID != 0 && this.Cart.GiftRegistryID != giftRegistryProductID)
            {
                MessageLiteral.Text = "You seem to have another Gift Registry saved. Please close your browser and try again.";
                return false;
            }
            else
                this.Cart.GiftRegistryID = giftRegistryProductID;
        }
        // If not add to cart
        return true;
    }

    private bool CanAddSubscription()
    {
        // If the cart has general coupons, do not allow subscription items
        if (CartProduct.IsSubscription && this.Cart.CartCoupons.Count(c => !c.ProductID.HasValue) > 0)
        {
            MessageLiteral.Text = FormsResources.NoGeneralCoupons;
            return false;
        }
        return true;
    }

    public void DeleteSavedCart()
    {
        if (HttpContext.Current.Profile["ShoppingCart"] != null)
        {
            Profile.ShoppingCart = new Cart();
            Profile.Save();
        }
    }

    /// <summary>
    /// For products with no options check inventory on load.
    /// </summary>
    public void CheckProductInventory()
    {
        if (ProductOptionsControl1.HasOptions)
            return;

        InventoryAction inventoryAction;
        InvertedSoftware.ShoppingCart.DataObjects.Inventory inventory = InvertedSoftware.ShoppingCart.DataLayer.Database.Inventory.GetProductInventory(CartProduct.ProductID, new List<int>());
        Enum.TryParse(inventory.InventoryActionID.ToString(), out inventoryAction);

        if (inventoryAction == InventoryAction.StopSellingProduct && inventory.ProductAmountInStock == 0)
        {
            AddButton.Enabled = false;
            MessageLiteral.Text = "Sorry Out of Stock.";
        }
        else if (inventoryAction == InventoryAction.ShowPreOrderProduct && inventory.ProductAmountInStock == 0)
        {
            MessageLiteral.Text = "Currently out of stock. Click here to pre order.";
        }
    }


    protected void GiftButton_Click(object sender, EventArgs e)
    {
        try
        {
            // If a user does not have a gift registry create one
            int giftRegistryID = GiftRegistries.GetGiftRegistry(0, GetLoggedCustomerID(), string.Empty, false).GiftRegistryID;
            if (giftRegistryID == 0)
            {
                GiftRegistry giftRegistry = new GiftRegistry() { CustomerID = GetLoggedCustomerID(), DateCreated = DateTime.Now, Active = true };
                giftRegistryID = GiftRegistries.AddGiftRegistry(giftRegistry);
            }
            // Add this product
            GiftRegistries.AddGiftRegistryProduct(new GiftRegistryProduct() { GiftRegistryID = giftRegistryID, ProductID = CartProduct.ProductID, Active = true });
            Response.Redirect("~/MyAccount/GiftRegistry.aspx");
        }
        catch (Exception ex)
        {
            MessageLiteral.Text = "Error " + ex.Message;
        }
    }
}