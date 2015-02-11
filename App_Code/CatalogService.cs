//------------------------------------------------------------------------------
// <copyright file="WebDataService.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
using System;
using System.Data.Services;
using System.Data.Services.Common;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel.Web;
using InvertedSoftware.ShoppingCart.DataLayer.Models;

public class CatalogService : DataService<ShoppingCartNET25Entities>
{
    // This method is called only once to initialize service-wide policies.
    public static void InitializeService(DataServiceConfiguration config)
    {
        // TODO: set rules to indicate which entity sets and service operations are visible, updatable, etc.
        // Examples:
        config.SetEntitySetAccessRule("Products", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("Categories", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("CustomFields", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("FeaturedProducts", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("Images", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("ProductCategories", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("ProductOptions", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("ProductTags", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("RelatedProducts", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("Tags", EntitySetRights.AllRead);

        //config.SetServiceOperationAccessRule("MyServiceOperation", ServiceOperationRights.All);
        config.DataServiceBehavior.MaxProtocolVersion = DataServiceProtocolVersion.V3;
    }
}
