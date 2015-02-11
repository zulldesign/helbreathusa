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

public partial class Admin_Upload : System.Web.UI.Page
{
    private string AllowedFiles = ".jpg|.jpeg|.gif|.bmp|.png";
    private int ProductID = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        ProductID = Convert.ToInt32(Request.QueryString["ProductID"]);
        if (ProductID == -1)
            Response.Redirect("Default.aspx");
    }
    protected void UploadButton_Click(object sender, EventArgs e)
    {
        if (ProductFileUpload.HasFiles)
        {
            foreach (HttpPostedFile file in ProductFileUpload.PostedFiles)
                UploadFile(file);
        }
    }

    private void UploadFile(HttpPostedFile file){
        string filePrefix = Guid.NewGuid().ToString().Replace("-", "");
        string fileName = filePrefix + Path.GetFileName(file.FileName);
        if (!AllowedFiles.Contains(Path.GetExtension(fileName)))
            return;

        fileName = Server.UrlDecode(fileName);
        String savePath = Path.Combine(HttpRuntime.AppDomainAppPath, "ProductImages", fileName);
        // Save the original image
        
        file.SaveAs(savePath);
        //Add to database and get back the ID
        using (ShoppingCartNET25Entities context = new ShoppingCartNET25Entities())
        {
            InvertedSoftware.ShoppingCart.DataLayer.Models.Image image = new InvertedSoftware.ShoppingCart.DataLayer.Models.Image();
            image.ImageTypeID = (int)InvertedSoftware.ShoppingCart.DataLayer.Database.ImageType.Original;
            image.ImageName = Path.GetFileName(savePath);
            image.ImageURL = fileName;
            image.ProductID = ProductID;
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
            thumnail.ProductID = ProductID;
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
            sThumnail.ProductID = ProductID;
            sThumnail.SortOrder = 1;
            sThumnail.Active = true;
            context.AddToImages(sThumnail);

            context.SaveChanges();
            MessageLabel.Text = "Your files ware saved. <a href=\"Products/List.aspx\">Go back to Product list</a>";
        }
    }
}