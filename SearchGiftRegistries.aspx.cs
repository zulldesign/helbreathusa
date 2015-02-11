using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.DataObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SearchGiftRegistries : BasePage
{
    string registry = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        MenuID = "gift";
        Page.Title = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + " : Search Gift Registry.";

        registry = Request["Registry"];
        if (!string.IsNullOrWhiteSpace(registry))
        {
            EmailTextBox.Text = registry;
            GiftRegistryListView.DataBind();
        }
    }

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;
        GiftRegistryListView.DataBind();
    }

    public GiftRegistry GiftRegistry { get; set; }

    // The return type can be changed to IEnumerable, however to support
    // paging and sorting, the following parameters must be added:
    //     int maximumRows
    //     int startRowIndex
    //     out int totalRowCount
    //     string sortByExpression
    public IEnumerable<InvertedSoftware.ShoppingCart.DataObjects.GiftRegistryProduct> GiftRegistryListView_GetData([Control("EmailTextBox", "Text")] string registry)
    {
        if (string.IsNullOrWhiteSpace(registry))
        {
            GiftRegistryListView.Visible = false;
            return null;
        }
        else
            GiftRegistryListView.Visible = true;

        GiftRegistry = GiftRegistries.GetGiftRegistry(0, 0, EmailTextBox.Text, true);
        if (GiftRegistry.IsPublic || GetLoggedCustomerID() > -1)
            return GiftRegistry.Products;
        else if (!GiftRegistry.IsPublic)
        {
            PrivateListLiteral.Visible = true;
            return null;
        }
        else
            return null;
    }
    protected void EmailTextBox_TextChanged(object sender, EventArgs e)
    {
        GiftRegistryListView.DataBind();
    }
}