<%@ WebHandler Language="C#" Class="SoftAddToCart" %>

using System;
using System.Web;
using System.Linq;
using InvertedSoftware.ShoppingCart.DataObjects;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.BusinessLayer;

public class SoftAddToCart : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {

        int productID = 0;
        int.TryParse(context.Request.QueryString["ProductID"], out productID);
        if (productID == 0)
            return;

        string response = string.Empty;
        Product product = Products.GetProduct(productID);
        if (!string.IsNullOrWhiteSpace(product.ProductLink))
            response = @"[{""Redirect"": ""Custom"", ""To"": """ + product.ProductLink + @"""}]";
        else if (Products.IsProductOptionsExist(productID))
            response = @"[{""Redirect"": ""Product""}]";
        else
        {
            StoreCart storeCart = new StoreCart();
            storeCart.DeleteSavedCart();

            CartManager manager = new CartManager(storeCart.Cart);
            try
            {
                manager.Add(productID);
                storeCart.Cart.Discounts = manager.Discounts;
                storeCart.Cart.Subtotal = manager.SubTotal;
                storeCart.Cart.Total = manager.Total;
                storeCart.Cart = manager.ShoppingCart;
                response = @"[{""Redirect"": ""Cart""}]";
            }
            catch (Exception ex)
            {
                response = @"[{""Error"": """ + ex.Message + @"""}]";
            }
        }

        context.Response.ContentType = "application/json";
        context.Response.Write(response);
        context.Response.Flush();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}