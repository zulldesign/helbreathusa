<%@ WebHandler Language="C#" Class="ViewHistory" %>

using System;
using System.Web;
using System.Collections.Generic;

using InvertedSoftware.ShoppingCart.DataObjects;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.BusinessLayer;

public class ViewHistory : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        var responseJson = string.Empty;
        int operationType = int.Parse(context.Request.QueryString["operationType"]);
        
        switch (operationType){
            case 1: // Add Product To View History
                AddProductToViewHistory(context, int.Parse(context.Request.QueryString["ProductID"]));
                break;
            case 2: //  Change History Settings
                ChangeHistorySettings(context, bool.Parse(context.Request.QueryString["HistoryOn"]));
                break;
            case 3: // Get Product History
                List<ProductDisplay> productHistory = GetProductHistory(context);
                // Get the reviews json string
                responseJson = Newtonsoft.Json.JsonConvert.SerializeObject(productHistory);
                break;
            default:
                break;
        }

        context.Response.ContentType = "application/json";
        context.Response.Write(responseJson);
        context.Response.Flush();
    }

    private void AddProductToViewHistory(HttpContext context, int ProductID)
    {
        var historyCookie = ExperienceManager.GetHistoryCookie(context);

        if (!Convert.ToBoolean(historyCookie.Values[Utils.HISTORY_COOKIE_ENABLED]))
            return;

        string products = historyCookie.Values[Utils.HISTORY_COOKIE_DATA];
        if (string.IsNullOrWhiteSpace(products))
            products = Convert.ToString(ProductID);
        else
        {
            // Add a product to the top of the string
            if (products.IndexOf(Convert.ToString(ProductID)) == -1)
                products = ProductID + "|" + products;
            //  make sure history contains only the last 5 products
            string[] history = products.Split('|');
            if (history.Length > 5)
            {
                Array.Resize(ref history, Utils.PRODUCTS_IN_HISTORY);
                products = String.Join("|", history);
            }
        }
        historyCookie.Values[Utils.HISTORY_COOKIE_DATA] = products;
        context.Response.Cookies.Add(historyCookie);
    }

  
    private void ChangeHistorySettings(HttpContext context, bool HistoryOn)
    {
        var historyCookie = ExperienceManager.GetHistoryCookie(context);
        historyCookie.Values[Utils.HISTORY_COOKIE_ENABLED] = HistoryOn.ToString();
        context.Response.Cookies.Add(historyCookie);
    }

    public List<ProductDisplay> GetProductHistory(HttpContext context)
    {
        context.Response.Headers.Add("Cache-Control", "no-cache");
        var historyCookie = ExperienceManager.GetHistoryCookie(context);
        string products = historyCookie.Values[Utils.HISTORY_COOKIE_DATA];
        if (string.IsNullOrWhiteSpace(products))
            return new List<ProductDisplay>();
        else
            return Products.GetProductViewHistory(products.Trim());
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}