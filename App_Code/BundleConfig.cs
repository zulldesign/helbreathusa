using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace InvertedSoftware.ShoppingCart.UI
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254726
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/WebFormsJs").Include(
                  "~/Scripts/WebForms/WebForms.js",
                  "~/Scripts/WebForms/WebUIValidation.js",
                  "~/Scripts/WebForms/MenuStandards.js",
                  "~/Scripts/WebForms/Focus.js",
                  "~/Scripts/WebForms/GridView.js",
                  "~/Scripts/WebForms/DetailsView.js",
                  "~/Scripts/WebForms/TreeView.js",
                  "~/Scripts/WebForms/WebParts.js"));

            bundles.Add(new ScriptBundle("~/bundles/MsAjaxJs").Include(
                "~/Scripts/WebForms/MsAjax/MicrosoftAjax.js",
                "~/Scripts/WebForms/MsAjax/MicrosoftAjaxApplicationServices.js",
                "~/Scripts/WebForms/MsAjax/MicrosoftAjaxTimer.js",
                "~/Scripts/WebForms/MsAjax/MicrosoftAjaxWebForms.js"));

            // Use the Development version of Modernizr to develop with and learn from. Then, when you’re
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/SiteMenu").Include(
              "~/Scripts/site.js"));

            bundles.Add(new ScriptBundle("~/bundles/Pager").Include(
               "~/Scripts/NumericPaging.js"));

            bundles.Add(new ScriptBundle("~/bundles/ProductPageServices").Include(
               "~/Scripts/InventoryService.js", "~/Scripts/HistoryService.js"));

            bundles.Add(new ScriptBundle("~/bundles/ProductReviews").Include(
               "~/Scripts/ProductReviews.js"));

            bundles.Add(new ScriptBundle("~/bundles/jRating").Include(
               "~/Scripts/jRating-master/jRating.jquery.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/ProductCarousel").Include(
               "~/Scripts/jcarousel.connected-carousels.js"));

            bundles.Add(new ScriptBundle("~/bundles/SoftAddToCart").Include(
              "~/Scripts/SoftAddToCart.js"));
        }
    }
}