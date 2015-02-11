using InvertedSoftware.ShoppingCart.BusinessLayer;
using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using InvertedSoftware.ShoppingCart.DataObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Register : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MenuID = "register";
        Page.Title = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + " : Register";
    }

    protected void RegisterButton_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;
        try
        {
            AddCustomer();
            Response.Redirect("MyAccount/Default.aspx");
        }
        catch (Exception ex)
        {
            MessageLabel.Text = "Error: " + ex.Message;
        }
    }

    protected void EmailCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (Customers.IsEmailExists(args.Value) || Membership.GetUser(args.Value) != null)
            args.IsValid = false;
        else
            args.IsValid = true;
    }

    private Customer AddCustomer()
    {
        Customer customer = new Customer()
        {
            Address = BillingAddressControl.Address,
            CellPhone = CellPhoneTextBox.Text,
            City = BillingAddressControl.City,
            Company = ComapnyTextBox.Text,
            CountryID = BillingAddressControl.CountryID,
            DateCreated = DateTime.Now,
            DateUpdated = DateTime.Now,
            DayPhone = DayPhoneTextBox.Text,
            Email = EmailTextBox.Text,
            EveningPhone = EveningPhoneTextBox.Text,
            Fax = FaxTextBox.Text,
            StateID = BillingAddressControl.StateID,
            FirstName = FirstNameTextBox.Text,
            LastName = LastNameTextBox.Text,
            ProvinceID = BillingAddressControl.ProvinceID,
            Zipcode = BillingAddressControl.Zipcode,
            Active = true
        };

        return CustomerManager.AddCustomer(customer);
    }
}