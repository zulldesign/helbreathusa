using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataObjects;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.BusinessLayer;
using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;

public partial class UserControls_ProductsSearchControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region Navigation Properties
    public int TotalRecords { get; set; }
    public int PageNumber { get; set; }
    public int PageSize { get; set; }

    public int PageCount
    {
        get
        {
            if (TotalRecords <= 0 || PageSize <= 0)
                return 1;
            else
                return ((TotalRecords + PageSize) - 1) / PageSize;
        }
    }
    #endregion

    public List<Product> DataSource
    {
        set { ProductsRepeater.DataSource = value; }
    }
    public override void DataBind()
    {
        ProductsRepeater.DataBind();
        if (PageCount > 1)
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "NumericPaging", "showPager(" + PageNumber + ", " + PageSize + ", " + TotalRecords + ", " + PageCount + ");", true);
    }

    #region Events
    protected void ProductsRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        HiddenField ProductLinkHiddenField = (HiddenField)((RepeaterItem)e.Item).FindControl("ProductLinkHiddenField");
        if (!string.IsNullOrWhiteSpace(ProductLinkHiddenField.Value))
        {
            Response.Redirect(ProductLinkHiddenField.Value);
            return;
        }
        HiddenField ProductIDHiddenField = (HiddenField)((RepeaterItem)e.Item).FindControl("ProductIDHiddenField");
        int productID = int.Parse(ProductIDHiddenField.Value);
        if (productID == -1)
            return;
        if (e.CommandName == "AddToCart")
        {
            DeleteSavedCart();

            CartManager manager = new CartManager(((BasePage)Page).Cart);
            try
            {
                manager.Add(productID);
                ((BasePage)Page).Cart = manager.ShoppingCart;
                Response.Redirect("~/ShoppingCart.aspx");
            }
            catch (Exception ex)
            {
                MessageLiteral.Text = ex.Message;
            }
        }
        else if (e.CommandName == "Customize")
        {
            Label ProductNameLabel = e.Item.FindControl("ProductNameLabel") as Label;
            Response.Redirect("/Product/" + HttpUtility.UrlEncode(ProductNameLabel.Text));
        }
    }

    protected void ProductsRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {


        Button AddButton = e.Item.FindControl("AddButton") as Button;
        HiddenField ProductIDHiddenField = e.Item.FindControl("ProductIDHiddenField") as HiddenField;
        if (AddButton == null || ProductIDHiddenField == null)
            return;
        if (Products.IsProductOptionsExist(int.Parse(ProductIDHiddenField.Value)))
        {
            AddButton.Text = "Customize";
            AddButton.CommandName = "Customize";
        }
        else
        {
            //Check Inventory
            InventoryAction inventoryAction;
            InvertedSoftware.ShoppingCart.DataObjects.Inventory inventory = InvertedSoftware.ShoppingCart.DataLayer.Database.Inventory.GetProductInventory(int.Parse(ProductIDHiddenField.Value), new List<int>());
            Enum.TryParse(inventory.InventoryActionID.ToString(), out inventoryAction);

            if (inventoryAction == InventoryAction.StopSellingProduct && inventory.ProductAmountInStock == 0)
            {
                AddButton.Enabled = false;
                AddButton.Text = "Out of Stock.";
            }
            else if (inventoryAction == InventoryAction.ShowPreOrderProduct && inventory.ProductAmountInStock == 0)
            {
                AddButton.Text = "Pre Order.";
            }
        }
    }
    #endregion

    public void DeleteSavedCart()
    {
        if (HttpContext.Current.Profile["ShoppingCart"] != null || ((Cart)HttpContext.Current.Profile["ShoppingCart"]).CartItems.Count() == 0)
        {
            Profile.SetPropertyValue("ShoppingCart", new Cart());
            Profile.Save();
        }
    }
}