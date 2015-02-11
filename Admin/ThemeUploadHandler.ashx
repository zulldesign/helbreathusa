<%@ WebHandler Language="C#" Class="ThemeUploadHandler" %>

using System;
using System.IO;
using System.Linq;
using System.Web;
using System.Net.Http;
using System.Threading.Tasks;
using System.IO.Compression;

public class ThemeUploadHandler : HttpTaskAsyncHandler
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
                    string savedFileName = Path.Combine(context.Server.MapPath("~/App_Data"), Path.GetFileName(hpf.FileName));
                    // Remove zip file if already there.
                    File.Delete(savedFileName);
                    // Save the uploaded file.
                    hpf.SaveAs(savedFileName);
                    // Unzip to the theme directory. Override old files. 
                    using (ZipArchive archive = ZipFile.OpenRead(savedFileName))
                    {
                        foreach (ZipArchiveEntry entry in archive.Entries)
                        {
                            if (!entry.FullName.EndsWith(".db", StringComparison.OrdinalIgnoreCase))
                            {
                                if(!Directory.Exists(Path.GetDirectoryName(Path.Combine(context.Server.MapPath("~/App_Themes"), entry.FullName))))
                                    Directory.CreateDirectory(Path.GetDirectoryName(Path.Combine(context.Server.MapPath("~/App_Themes"), entry.FullName)));
                                entry.ExtractToFile(Path.Combine(context.Server.MapPath("~/App_Themes"), entry.FullName), true);
                            }
                        }
                    }
                    // Clean up the App_Themes folder by removing all files not within a theme folder.
                    Directory.GetFiles(context.Server.MapPath("~/App_Themes")).ToList<string>().ForEach((i) => File.Delete(i));
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

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}