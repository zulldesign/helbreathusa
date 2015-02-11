<%@ WebHandler Language="C#" Class="FilesUploadHandler" %>

using System;
using System.IO;
using System.Web;
using System.Threading.Tasks;

public class FilesUploadHandler : HttpTaskAsyncHandler
{
    public override async Task ProcessRequestAsync(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        try
        {
            await Task.Factory.StartNew(() =>
            {
                foreach (string file in context.Request.Files)
                {
                    HttpPostedFile hpf = context.Request.Files[file] as HttpPostedFile;
                    if (hpf.ContentLength == 0)
                        continue;
                    string savedFileName = Path.Combine(context.Server.MapPath("~/UserFiles"), Path.GetFileName(hpf.FileName));
                    // Remove user file if already there.
                    File.Delete(savedFileName);
                    // Save the uploaded file.
                    hpf.SaveAs(savedFileName);
                }

            });
        }
        catch (Exception e)
        {
            context.Response.Write(e);
            return;
        }

        context.Response.Write("OK");
    }
    
  
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}