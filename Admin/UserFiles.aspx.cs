using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_UserFiles : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public long DirectorySize { get; set; }
    public int TotalFiles { get; set; }

    // The id parameter name should match the DataKeyNames value set on the control
    public void UserFilesGridView_DeleteItem(string name)
    {
        try
        {
            File.Delete(Path.Combine(Server.MapPath("~/UserFiles"), name));
            MessageLiteral.Text = "File Deleted";
        }
        catch (Exception e)
        {
            MessageLiteral.Text = e.Message;
        }
    }

    // The return type can be changed to IEnumerable, however to support
    // paging and sorting, the following parameters must be added:
    //     int maximumRows
    //     int startRowIndex
    //     out int totalRowCount
    //     string sortByExpression
    public IQueryable<FileInfo> UserFilesGridView_GetData(int maximumRows, int startRowIndex, out int totalRowCount)
    {
        totalRowCount = 0;
        DirectorySize = 0;
        DirectoryInfo di = new DirectoryInfo(Server.MapPath("~/UserFiles"));
        var files = di.EnumerateFiles();
        foreach (var file in files)
        {
            totalRowCount++;
            DirectorySize = DirectorySize + file.Length;
        }

        TotalFiles = totalRowCount;
        return files.Skip(startRowIndex * maximumRows).Take(maximumRows).AsQueryable();
    }

    protected void UserFilesGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // loop all data rows
            foreach (DataControlFieldCell cell in e.Row.Cells)
            {
                // check all cells in one row
                foreach (Control control in cell.Controls)
                {
                    // Must use LinkButton here instead of ImageButton
                    // if you are having Links (not images) as the command button.
                    LinkButton button = control as LinkButton;
                    if (button != null && button.CommandName == "Delete")
                        // Add delete confirmation
                        button.OnClientClick = "return confirm('Are you sure you want to delete this file?');";
                }
            }
        }
    }
}