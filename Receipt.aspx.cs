using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Cache;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.DataObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Receipt : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + " : Receipt";
        CustomerID = int.Parse(Request["CustomerID"]);
        OrderID = int.Parse(Request["OrderID"]);

        Order = Orders.GetOrder(OrderID);
        if (Order.CustomerID != CustomerID || Order.OrderNumber != Request["OrderNumber"]) // This is not the customer's order
            Response.Redirect("Default.aspx");
        else
        {
            Customer = Customers.GetCustomer(CustomerID);
        }

    }

    #region Properties
    public int CustomerID { get; set; }
    public int OrderID { get; set; }
    public Order Order { get; set; }
    public Customer Customer { get; set; }
    public string State
    {
        get
        {
            string state = string.Empty;
            if (Order.StateID.HasValue)
                CacheManager.GetCachedLookupTable(LookupDataEnum.GetStates).TryGetValue(Order.StateID.Value, out state);
            return state;
        }
    }
    public string Province
    {
        get
        {
            string province = string.Empty;
            if (Order.ProvinceID.HasValue)
                CacheManager.GetCachedLookupTable(LookupDataEnum.GetProvinces).TryGetValue(Order.ProvinceID.Value, out province);
            return province;
        }
    }
    public string Country
    {
        get
        {
            return CacheManager.GetCachedLookupTable(LookupDataEnum.GetCountries)[Order.CountryID];
        }
    }
    #endregion
}