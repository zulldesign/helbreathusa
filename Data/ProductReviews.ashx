<%@ WebHandler Language="C#" Class="ProductReviews" %>

using System;
using System.Web;
using InvertedSoftware.ShoppingCart.DataLayer.Database;

public class ProductReviews : IHttpHandler
{

    public void ProcessRequest(HttpContext context) {
        int productID = int.Parse(context.Request.QueryString["productID"]);
        int startRowIndex = int.Parse(context.Request.QueryString["startRowIndex"]);
        int maximumRows = int.Parse(context.Request.QueryString["maximumRows"]);
        
        int productReviewCount = 0;
        var reviews = Reviews.GetProductReviews(productID, startRowIndex, maximumRows, out productReviewCount);
        // Get the reviews json string
        var reviewsJSON = Newtonsoft.Json.JsonConvert.SerializeObject(reviews);
        //Wrap the total about it.
        reviewsJSON = @"[{""total"": """ + productReviewCount + @""", ""items"":  "+ reviewsJSON + "}]";
        // Send to the client
        context.Response.ContentType = "application/json";
        context.Response.Write(reviewsJSON);
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