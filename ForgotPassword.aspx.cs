using InvertedSoftware.ShoppingCart.BusinessLayer.Controls;
using InvertedSoftware.ShoppingCart.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ForgotPassword : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) + " : Forgot Password.";
        PasswordRecovery1.MailDefinition.From = StoreConfiguration.GetConfigurationValue(ConfigurationKey.ContactEmail);
    }
    protected void PasswordRecovery1_SendingMail(object sender, MailMessageEventArgs e)
    {
        // Send using the store's SMTP
        try
        {
            Email.SendSimpleEmail(e.Message);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        e.Cancel = true;
    }
}