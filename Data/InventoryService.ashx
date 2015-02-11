<%@ WebHandler Language="C#" Class="InventoryService" %>

using System;
using System.Web;
using System.Collections.Generic;
using InvertedSoftware.ShoppingCart.DataObjects;
using InvertedSoftware.ShoppingCart.DataLayer.Database;

public class InventoryService : IHttpHandler
{

    public void ProcessRequest(HttpContext context) {
        context.Response.ContentType = "text/plain";
        int productID = int.Parse(context.Request["ProductID"]);
        string[] productOptions = new string[0];
        if (!string.IsNullOrWhiteSpace(context.Request["ProductOptions"]) && context.Request["ProductOptions"] != "[]")
        {
            string cleanOptions = string.Empty;
            foreach (var c in context.Request["ProductOptions"])
                if (c != '[' && c != ']' && c != '"' && c != '\\')
                    cleanOptions += c;
            productOptions = cleanOptions.Split(','); //["1","3"]
        }
        
        int quantity = int.Parse(context.Request["quantity"]);
        
        context.Response.Write(GetProductStockStatus(productID, productOptions, quantity, context));
    }

    public int GetProductStockStatus(int ProductID, string[] ProductOptions, int Quantity, HttpContext context)
    {
        context.Response.Headers.Add("Cache-Control", "no-cache");

        int productStockStatus = 1;
        List<int> productOptions = new List<int>();
        Array.ForEach(ProductOptions, (o) => productOptions.Add(Convert.ToInt32(o)));

        InvertedSoftware.ShoppingCart.DataObjects.Inventory inventory = InvertedSoftware.ShoppingCart.DataLayer.Database.Inventory.GetProductInventory(ProductID, productOptions);
        InventoryAction inventoryAction;
        Enum.TryParse(inventory.InventoryActionID.ToString(), out inventoryAction);

        switch (inventoryAction)
        {
            case InventoryAction.StopSellingOption:
                if (inventory.ProductAmountInStock < Quantity)
                    productStockStatus = 0;
                break;
            case InventoryAction.StopSellingProduct:
                if (inventory.ProductAmountInStock < Quantity)
                    productStockStatus = 0;
                break;
            case InventoryAction.ShowPreOrderOption:
                if (inventory.ProductAmountInStock < Quantity)
                    productStockStatus = 2;
                break;
            case InventoryAction.ShowPreOrderProduct:
                if (inventory.ProductAmountInStock < Quantity)
                    productStockStatus = 2;
                break;
            default:
                productStockStatus = 1;
                break;
        }

        return productStockStatus;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}