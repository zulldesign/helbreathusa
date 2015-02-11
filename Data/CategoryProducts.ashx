<%@ WebHandler Language="C#" Class="CategoryProducts" %>

using System;
using System.Linq;
using System.Web;
using System.Collections.Generic;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.BusinessLayer;

public class CategoryProducts : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        // Page number
        int pageNumber = 0;
        int.TryParse(context.Request.QueryString["Page"], out pageNumber);
        // Page size
        int perPage = 10;
        int.TryParse(context.Request.QueryString["PerPage"], out perPage);
        if (perPage == 0)
            perPage = 10;
        // Sort order
        SortOrder sortOrder = SortOrder.DontSort;
        Enum.TryParse<SortOrder>(context.Request.QueryString["Sort"], out sortOrder);

        int totalRecords = 0;
        bool isEnabled = true;
        var products = Products.GetCategoryProducts(HttpUtility.UrlDecode(context.Request.QueryString["CategoryName"]), pageNumber, perPage, out totalRecords, sortOrder).Select((p) => new
        {
            ProductID = p.ProductID,
            ProductName = p.ProductName,
            Thumbnail = p.Thumbnail,
            Description = p.Description,
            BuyButtonText = ExperienceManager.CheckInventory(p.IsInStock, p.InventoryActionID, out isEnabled),
            IsEnabled = isEnabled
        });
        var productsJSON = Newtonsoft.Json.JsonConvert.SerializeObject(products);
        context.Response.ContentType = "application/json";
        context.Response.Write(productsJSON);
        context.Response.Flush();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}