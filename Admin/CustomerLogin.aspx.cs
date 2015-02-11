using InvertedSoftware.ShoppingCart.DataLayer.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_CustomerLogin : System.Web.UI.Page
{
    public MembershipUser user;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            LoadMember();

    }

    private void LoadMember()
    {
        user = Membership.GetUser(Customers.GetCustomerMemberID(int.Parse(Request["CustomerID"])));
        if (user == null)
            Response.Redirect("Default.aspx");
        if (user.IsLockedOut)
            UnblockButton.Visible = true;
        else
            UnblockButton.Visible = false;

        EmailTextBox.Text = user.Email;
        ActiveCheckBox.Checked = user.IsApproved;
    }
    protected void SaveButton_Click(object sender, EventArgs e)
    {
        try
        {
            user = Membership.GetUser(Customers.GetCustomerMemberID(int.Parse(Request["CustomerID"])));
            user.Email = EmailTextBox.Text;
            user.IsApproved = ActiveCheckBox.Checked;
            Membership.UpdateUser(user);
            MessageLiteral.Text = "Customer login updated. <a href='Customers/List.aspx'>Back to list</a>";
        }
        catch (Exception ex)
        {
            MessageLiteral.Text = ex.Message;
        }
    }
    protected void UnblockButton_Click(object sender, EventArgs e)
    {
        try
        {
            user = Membership.GetUser(Customers.GetCustomerMemberID(int.Parse(Request["CustomerID"])));
            user.UnlockUser();
            Membership.UpdateUser(user);
            MessageLiteral.Text = "User unblocked. <a href='Customers/List.aspx'>Back to list</a>";
        }
        catch (Exception ex)
        {
            MessageLiteral.Text = ex.Message;
        }
    }
}