using InvertedSoftware.ShoppingCart.BusinessLayer;
using InvertedSoftware.ShoppingCart.DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Wizards_AddProductWizard : System.Web.UI.Page
{
    ShoppingCartNET25Entities context = new ShoppingCartNET25Entities();
    private string AllowedFiles = ".jpg|.jpeg|.gif|.bmp|.png";

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void SaveButton_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;

        try
        {
            int productID = AddProduct();
            AddProductImages(productID);
            MessageLiteral.Text = "Product added. Please add another product or use the navigation menu to continue.";
        }
        catch (Exception ex)
        {
            MessageLiteral.Text = ex.Message;
        }
    }

    public IEnumerable<Category> CategoryDropDownList_GetData()
    {
        return context.Categories;
    }

    private int AddProduct()
    {
        Product product = new Product()
        {
            Active = Active.Checked,
            CatalogNumber = CatalogNumber.Text,
            IsDownloadable = IsDownloadable.Checked,
            IsDownloadKeyRequired = IsDownloadKeyRequired.Checked,
            IsSubscription = IsSubscription.Checked,
            IsDownloadKeyUnique = IsDownloadKeyUnique.Checked,
            ProductName = ProductName.Text, 
            Description = Description.Text, 
            IsReviewEnabled = IsReviewEnabled.Checked,
            Price = decimal.Parse(Price.Text)
        };

        decimal saleprice = 0;
        decimal.TryParse(SalePrice.Text, out saleprice);
        product.SalePrice = saleprice;

        decimal ratingScore = 0;
        decimal.TryParse(RatingScore.Text, out ratingScore);
        product.RatingScore = ratingScore;

        decimal subscriptionSetupFee = 0;
        decimal.TryParse(SubscriptionSetupFee.Text, out subscriptionSetupFee);
        product.SubscriptionSetupFee = subscriptionSetupFee;

        int totalReviewCount = 0;
        int.TryParse(TotalReviewCount.Text, out totalReviewCount);
        product.TotalReviewCount = totalReviewCount;
     
        if (!string.IsNullOrWhiteSpace(CategoryDropDownList.SelectedValue))
            product.ProductCategories.Add(new ProductCategory()
            {
                CategoryID = int.Parse(CategoryDropDownList.SelectedValue),
                Active = true
            });

        context.AddToProducts(product);
        context.SaveChanges();

        return product.ProductID;
    }


    private void AddProductImages(int productID)
    {
        if (ProductImagesUpload.HasFiles)
        {
            foreach (HttpPostedFile hpf in ProductImagesUpload.PostedFiles)
            {
                SaveImage(hpf, productID);
            }
        }
    }

    private void SaveImage(HttpPostedFile ProductFileUpload, int productID)
    {
        string filePrefix = Guid.NewGuid().ToString().Replace("-", "");
        string fileName = filePrefix + Path.GetFileName(ProductFileUpload.FileName);
        if (!AllowedFiles.Contains(Path.GetExtension(fileName)))
            return;

        fileName = Server.UrlDecode(fileName);
        String savePath = Path.Combine(HttpRuntime.AppDomainAppPath, "ProductImages", fileName);
        //savePath += fileName;
        // Save the original image
        ProductFileUpload.SaveAs(savePath);
        //Add to database and get back the ID

        InvertedSoftware.ShoppingCart.DataLayer.Models.Image image = new InvertedSoftware.ShoppingCart.DataLayer.Models.Image();
        image.ImageTypeID = (int)InvertedSoftware.ShoppingCart.DataLayer.Database.ImageType.Original;
        image.ImageName = Path.GetFileName(savePath);
        image.ImageURL = fileName;
        image.ProductID = productID;
        image.SortOrder = 1;
        image.Active = true;
        context.AddToImages(image);

        //Create a large thumbnail
        ImageProcessor processor = new ImageProcessor();
        processor.ProcessedImage = (Bitmap)System.Drawing.Image.FromFile(savePath);
        processor.resizeToMaxFitImage(200).Save(HttpRuntime.AppDomainAppPath + @"\ProductImages\" + Path.GetFileNameWithoutExtension(savePath) + "_m" + Path.GetExtension(savePath));
        processor.ProcessedImage.Dispose();
        processor.ProcessedImage = null;
        // Add to database
        InvertedSoftware.ShoppingCart.DataLayer.Models.Image thumnail = new InvertedSoftware.ShoppingCart.DataLayer.Models.Image();
        thumnail.ImageTypeID = (int)InvertedSoftware.ShoppingCart.DataLayer.Database.ImageType.Thumb200;
        thumnail.ParentID = image.ImageID;
        thumnail.ImageName = Path.GetFileNameWithoutExtension(savePath) + "_m";
        thumnail.ImageURL = Path.GetFileNameWithoutExtension(savePath) + "_m" + Path.GetExtension(savePath);
        thumnail.ProductID = productID;
        thumnail.SortOrder = 1;
        thumnail.Active = true;
        context.AddToImages(thumnail);

        //Create a small thumbnail
        processor.ProcessedImage = (Bitmap)System.Drawing.Image.FromFile(savePath);
        processor.resizeImage(75, 75).Save(HttpRuntime.AppDomainAppPath + @"\ProductImages\" + Path.GetFileNameWithoutExtension(savePath) + "_t" + Path.GetExtension(savePath));
        processor.ProcessedImage.Dispose();
        processor.ProcessedImage = null;
        // Add to database
        InvertedSoftware.ShoppingCart.DataLayer.Models.Image sThumnail = new InvertedSoftware.ShoppingCart.DataLayer.Models.Image();
        sThumnail.ImageTypeID = (int)InvertedSoftware.ShoppingCart.DataLayer.Database.ImageType.Thumb75;
        sThumnail.ParentID = image.ImageID;
        sThumnail.ImageName = Path.GetFileNameWithoutExtension(savePath) + "_t";
        sThumnail.ImageURL = Path.GetFileNameWithoutExtension(savePath) + "_t" + Path.GetExtension(savePath);
        sThumnail.ProductID = productID;
        sThumnail.SortOrder = 1;
        sThumnail.Active = true;
        context.AddToImages(sThumnail);

        context.SaveChanges();
    }
    protected void ProductNameCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = (context.Products.Where(p => p.ProductName == args.Value).Count() == 0);
    }

    protected void CatalogNumberCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = (context.Products.Where(p => p.CatalogNumber == args.Value).Count() == 0);
    }
}