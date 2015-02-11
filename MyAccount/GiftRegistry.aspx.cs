using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.DataObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyAccount_GiftRegistry : BasePage
{
    private GiftRegistry giftRegistry = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        MenuID = "account";
    }
    protected void GiftRegistryListView_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Remove")
        {
            GiftRegistries.RemoveGiftRegistryProduct(GetLoggedCustomerID(), Convert.ToInt32(e.CommandArgument));
            GiftRegistryListView.DataBind();
        }
    }

    protected void VisibilityRadioButtonList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (giftRegistry == null)
            giftRegistry = GiftRegistries.GetGiftRegistry(0, GetLoggedCustomerID(), string.Empty, true);

        // Create a registry if it doesnt exist
        if (giftRegistry.GiftRegistryID == 0)
        {
            giftRegistry = new GiftRegistry() { CustomerID = GetLoggedCustomerID(), DateCreated = DateTime.Now, Active = true };
            giftRegistry.GiftRegistryID = GiftRegistries.AddGiftRegistry(giftRegistry);
        }
        GiftRegistries.UpdateGiftRegistryPublic(giftRegistry.GiftRegistryID, Convert.ToBoolean(VisibilityRadioButtonList.SelectedValue));
    }

    public IEnumerable<InvertedSoftware.ShoppingCart.DataObjects.GiftRegistryProduct> GiftRegistryListView_GetData()
    {
        giftRegistry = GiftRegistries.GetGiftRegistry(0, GetLoggedCustomerID(), string.Empty, true);
        if (giftRegistry.IsPublic)
            VisibilityRadioButtonList.SelectedValue = "true";
        else
            VisibilityRadioButtonList.SelectedValue = "false";

        return giftRegistry.Products;
     
    }
}