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

public partial class UserControls_ProductsGridControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region Navigation Properties
    public int TotalRecords { get; set; }
    public int PageNumber { get; set; }
    public int PageSize { get; set; }
    public bool IsInfiniteScroll { get; set; }

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

    public List<CategoryProduct> DataSource
    {
        set { ProductsRepeater.DataSource = value; }
        get { return (List<CategoryProduct>)ProductsRepeater.DataSource; }
    }
    public override void DataBind()
    {
        ProductsRepeater.DataBind();
        if (PageCount > 1 && !IsInfiniteScroll)
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "NumericPaging", "showPager(" + PageNumber + ", " + PageSize + ", " + TotalRecords + ", " + PageCount + ");", true);
    }

    #region Events
    protected void ProductsRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Button AddButton = e.Item.FindControl("AddButton") as Button;
        HiddenField ProductIDHiddenField = e.Item.FindControl("ProductIDHiddenField") as HiddenField;
        HiddenField IsInStockHiddenField = e.Item.FindControl("IsInStockHiddenField") as HiddenField;
        HiddenField InventoryActionIDHiddenField = e.Item.FindControl("InventoryActionIDHiddenField") as HiddenField;
        if (AddButton == null || ProductIDHiddenField == null || IsInStockHiddenField == null || InventoryActionIDHiddenField == null)
            return;
        bool isInStock;
        bool? isInStockNullable = null;
        if (!string.IsNullOrWhiteSpace(IsInStockHiddenField.Value))
        {
            bool.TryParse(IsInStockHiddenField.Value, out isInStock);
            isInStockNullable = isInStock;
        }
        int inventoryActionID;
        int? inventoryActionIDNullable = null;
        if (!string.IsNullOrWhiteSpace(InventoryActionIDHiddenField.Value))
        {
            int.TryParse(InventoryActionIDHiddenField.Value, out inventoryActionID);
            inventoryActionIDNullable = inventoryActionID;
        }
        
        bool isEnabled = true;
        AddButton.Text = ExperienceManager.CheckInventory(isInStockNullable, inventoryActionIDNullable, out isEnabled);
        AddButton.Enabled = isEnabled;
    }
    #endregion
}
