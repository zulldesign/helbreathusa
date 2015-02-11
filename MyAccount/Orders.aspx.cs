using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.ModelBinding;

public partial class MyAccount_Orders : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MenuID = "account";
    }

    public string GetDownloadText(object downloadURL, object downloadKey)
    {
        if (downloadURL == null)
            return string.Empty;

        string downloadURLText = Convert.ToString(downloadURL);
        string downloadKeyText = Convert.ToString(downloadKey);
        string downloadText = string.Empty;
        if (!string.IsNullOrWhiteSpace(downloadURLText))
            downloadText += @"<br><a href=""" + downloadURLText + @""" target=""_blank"">Download</a>";
        if (!string.IsNullOrWhiteSpace(downloadKeyText))
            downloadText += @"<br>Key:" + downloadKeyText;

        return downloadText;
    }

    // The return type can be changed to IEnumerable, however to support
    // paging and sorting, the following parameters must be added:
    //     int maximumRows
    //     int startRowIndex
    //     out int totalRowCount
    //     string sortByExpression
    public IEnumerable<InvertedSoftware.ShoppingCart.DataObjects.OrderItem> OrderProductsGridView_GetData([Control("OrdersGridView")] int? orderID)
    {
        if (orderID.HasValue)
            return Orders.GetOrderItems(orderID.Value);
        return null;
    }

    // The return type can be changed to IEnumerable, however to support
    // paging and sorting, the following parameters must be added:
    //     int maximumRows
    //     int startRowIndex
    //     out int totalRowCount
    //     string sortByExpression
    public IQueryable<InvertedSoftware.ShoppingCart.DataObjects.OrderDisplay> OrdersGridView_GetData(int maximumRows, int startRowIndex, out int totalRowCount)
    {
        return Orders.GetOrders(GetLoggedCustomerID(), DateTime.Now.AddYears(-100), DateTime.Now.AddYears(100), startRowIndex, maximumRows, out totalRowCount).AsQueryable();
    }
}