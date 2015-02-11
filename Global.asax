<%@ Application Language="C#" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.UI" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace="System.Web.DynamicData" %>
<%@ Import Namespace="System.Web.UI" %>

<script runat="server">

    private static MetaModel s_defaultModel = new MetaModel();
    public static MetaModel DefaultModel
    {
        get
        {
            return s_defaultModel;
        }
    }

    public static void RegisterRoutes(RouteCollection routes)
    {
        //                    IMPORTANT: DATA MODEL REGISTRATION 
        // Uncomment this line to register an ADO.NET Entity Framework model for ASP.NET Dynamic Data.
        // Set ScaffoldAllTables = true only if you are sure that you want all tables in the
        // data model to support a scaffold (i.e. templates) view. To control scaffolding for
        // individual tables, create a partial class for the table and apply the
        // [ScaffoldTable(true)] attribute to the partial class.
        // Note: Make sure that you change "YourDataContextType" to the name of the data context
        // class in your application.
        // See http://go.microsoft.com/fwlink/?LinkId=257395 for more information on how to add and configure an Entity Data model to this project
        DefaultModel.RegisterContext(typeof(InvertedSoftware.ShoppingCart.DataLayer.Models.ShoppingCartNET25Entities), new ContextConfiguration() { ScaffoldAllTables = true });
        DefaultModel.DynamicDataFolderVirtualPath = "~/Admin/DynamicData";
        // The following statement supports separate-page mode, where the List, Detail, Insert, and 
        // Update tasks are performed by using separate pages. To enable this mode, uncomment the following 
        // route definition, and comment out the route definitions in the combined-page mode section that follows.
        routes.Add(new DynamicDataRoute("Admin/{table}/{action}.aspx")
        {
            Constraints = new RouteValueDictionary(new { action = "List|Details|Edit|Insert" }),
            Model = DefaultModel
        });

        // The following statements support combined-page mode, where the List, Detail, Insert, and
        // Update tasks are performed by using the same page. To enable this mode, uncomment the
        // following routes and comment out the route definition in the separate-page mode section above.
        //routes.Add(new DynamicDataRoute("{table}/ListDetails.aspx") {
        //    Action = PageAction.List,
        //    ViewName = "ListDetails",
        //    Model = DefaultModel
        //});

        //routes.Add(new DynamicDataRoute("{table}/ListDetails.aspx") {
        //    Action = PageAction.Details,
        //    ViewName = "ListDetails",
        //    Model = DefaultModel
        //});

        routes.MapPageRoute("", "Product/{ProductName}", "~/Product.aspx");
        routes.MapPageRoute("", "Category/{CategoryName}", "~/Category.aspx");
        routes.MapPageRoute("", "Pages/{PageName}", "~/CustomPage.aspx");
        routes.MapPageRoute("", "News", "~/News.aspx");
        routes.MapPageRoute("", "NewsItem/{NewsItem}", "~/NewsItem.aspx");
        routes.MapPageRoute("", "Search/", "~/Search.aspx");

    }

    public override string GetVaryByCustomString(HttpContext context, string arg)
    {
        object value;
        if (arg == "ProductName")
        {
           
            if (!context.Request.RequestContext.RouteData.Values.TryGetValue("ProductName", out value))
            {
                return null;
            }

            return value.ToString();
        }
        else if (arg == "CategoryName")
        {
            if (!context.Request.RequestContext.RouteData.Values.TryGetValue("CategoryName", out value))
            {
                return null;
            }

            return value.ToString();
        }
        else if (arg == "CategoryPage")
        {
            // Apparel?PerPage=50&Sort=LowtoHigh
            int perPage = 20;
            string sort = "LowtoHigh";
            int pageNumber = 0;
            if (!context.Request.RequestContext.RouteData.Values.TryGetValue("CategoryName", out value))
                return null;
            if (!string.IsNullOrWhiteSpace(context.Request.QueryString["PerPage"]))
                int.TryParse(context.Request.QueryString["PerPage"], out perPage);
            if (!string.IsNullOrWhiteSpace(context.Request.QueryString["sort"]))
                sort = context.Request.QueryString["sort"];
            if (!string.IsNullOrWhiteSpace(context.Request.QueryString["Page"]))
            int.TryParse(context.Request.QueryString["Page"], out pageNumber);

            return String.Format("c-{0}pp{1}s{2}p{3}", value.ToString(), perPage, sort, pageNumber);
        }
        return base.GetVaryByCustomString(context, arg);
    }

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        InvertedSoftware.ShoppingCart.DataLayer.Database.StoreConfigurations.LoadStoreConfiguration();
        BundleConfig.RegisterBundles(BundleTable.Bundles);
        AuthConfig.RegisterOpenAuth();
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        RegisterRoutes(RouteTable.Routes);
    }
    
    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        try
        {
            Exception objErr = Server.GetLastError().GetBaseException();
            InvertedSoftware.ShoppingCart.Common.Utils.WritePageException(objErr, Request.Url.ToString());
        }
        finally
        {
            //Server.ClearError();
        }
    }

</script>
