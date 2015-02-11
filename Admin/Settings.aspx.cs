using InvertedSoftware.ShoppingCart.Common;
using InvertedSoftware.ShoppingCart.DataLayer.Cache;
using InvertedSoftware.ShoppingCart.DataLayer.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Settings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            LoadForm();
    }
    protected void EditButton_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;

        try
        {
            StoreConfiguration.UpdateValue(ConfigurationKey.StoreName, StoreName.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.StoreURL, StoreURL.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.SalesTeamEmail, SalesTeamEmail.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.NewOrdersEmail, NewOrdersEmail.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.ContactEmail, ContactEmail.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.PayPalAPIUsername, PayPalAPIUsername.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.PayPalAPIPassword, PayPalAPIPassword.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.PayPalAPISignature, PayPalAPISignature.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.PaypalTestMode, PaypalTestMode.Checked.ToString().ToLower());
            StoreConfiguration.UpdateValue(ConfigurationKey.GoogleCheckoutEnabled, GoogleCheckoutEnabled.Checked.ToString().ToLower());
            StoreConfiguration.UpdateValue(ConfigurationKey.GoogleMerchantID, GoogleMerchantID.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.GoogleMerchantkey, GoogleMerchantkey.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.GoogleImageButtonURL, GoogleImageButtonURL.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.GoogleCheckoutURL, GoogleCheckoutURL.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.AuthorizeNetTestMode, AuthorizeNetTestMode.Checked.ToString().ToLower());
            StoreConfiguration.UpdateValue(ConfigurationKey.AuthorizeNetAPILoginID, AuthorizeNetAPILoginID.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.AuthorizeNetTransactionKey, AuthorizeNetTransactionKey.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.IsProductCacheEnabled, IsProductCacheEnabled.Checked.ToString().ToLower());
            StoreConfiguration.UpdateValue(ConfigurationKey.IsSSLInstalled, IsSSLInstalled.Checked.ToString().ToLower());
            StoreConfiguration.UpdateValue(ConfigurationKey.PaymentGateway, PaymentGateway.SelectedValue);
            StoreConfiguration.UpdateValue(ConfigurationKey.GoogleAnalytics, GoogleAnalytics.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.FacebookPage, FacebookPage.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.TwitterPage, TwitterPage.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.YouTubeChannel, YouTubeChannel.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.LinkedInPage, LinkedInPage.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.SMTPServer, SMTPServer.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.SMTPPort, SMTPPort.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.SMTPUser, SMTPUser.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.SMTPPassword, SMTPPassword.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.LicenseNumber, LicenseNumber.Text);
            StoreConfiguration.UpdateValue(ConfigurationKey.NewsletterOptIn, NewsletterOptIn.Checked.ToString().ToLower());

            StoreConfigurations.SaveAll();
            ErrorLiteral.Text = "Configuration Saved";
        }
        catch (Exception ex)
        {
            ErrorLiteral.Text = "ERROR Saving configuration: " + ex.Message;
        }
    }

    private void LoadForm()
    {
        StoreName.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName);
        StoreURL.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreURL);
        SalesTeamEmail.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.SalesTeamEmail);
        NewOrdersEmail.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.NewOrdersEmail);
        ContactEmail.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.ContactEmail);
        PayPalAPIUsername.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.PayPalAPIUsername);
        PayPalAPIPassword.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.PayPalAPIPassword);
        PayPalAPISignature.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.PayPalAPISignature);
        bool paypalTestMode = false;
        bool.TryParse(StoreConfiguration.GetConfigurationValue(ConfigurationKey.PaypalTestMode), out paypalTestMode);
        PaypalTestMode.Checked = paypalTestMode;
        bool googleCheckoutEnabled = false;
        bool.TryParse(StoreConfiguration.GetConfigurationValue(ConfigurationKey.GoogleCheckoutEnabled), out googleCheckoutEnabled);
        GoogleCheckoutEnabled.Checked = googleCheckoutEnabled;
        GoogleMerchantID.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.GoogleMerchantID);
        GoogleMerchantkey.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.GoogleMerchantkey);
        GoogleImageButtonURL.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.GoogleImageButtonURL);
        GoogleCheckoutURL.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.GoogleCheckoutURL);
        bool authorizeNetTestMode = false;
        bool.TryParse(StoreConfiguration.GetConfigurationValue(ConfigurationKey.AuthorizeNetTestMode), out authorizeNetTestMode);
        AuthorizeNetTestMode.Checked = authorizeNetTestMode;
        AuthorizeNetAPILoginID.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.AuthorizeNetAPILoginID);
        AuthorizeNetTransactionKey.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.AuthorizeNetTransactionKey);
        bool isProductCacheEnabled = false;
        bool.TryParse(StoreConfiguration.GetConfigurationValue(ConfigurationKey.IsProductCacheEnabled), out isProductCacheEnabled);
        IsProductCacheEnabled.Checked = isProductCacheEnabled;
        bool isSSLInstalled = false;
        bool.TryParse(StoreConfiguration.GetConfigurationValue(ConfigurationKey.IsSSLInstalled), out isSSLInstalled);
        IsSSLInstalled.Checked = isSSLInstalled;
        var paymentItem = PaymentGateway.Items.FindByValue(StoreConfiguration.GetConfigurationValue(ConfigurationKey.PaymentGateway));
        if (paymentItem != null)
            paymentItem.Selected = true;
        GoogleAnalytics.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.GoogleAnalytics);
        FacebookPage.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.FacebookPage);
        TwitterPage.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.TwitterPage);
        YouTubeChannel.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.YouTubeChannel);
        LinkedInPage.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.LinkedInPage);
        SMTPServer.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.SMTPServer);
        SMTPPort.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.SMTPPort);
        SMTPUser.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.SMTPUser);
        SMTPPassword.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.SMTPPassword);
        LicenseNumber.Text = StoreConfiguration.GetConfigurationValue(ConfigurationKey.LicenseNumber);
        bool newsletterOptIn = true;
        bool.TryParse(StoreConfiguration.GetConfigurationValue(ConfigurationKey.NewsletterOptIn), out newsletterOptIn);
        NewsletterOptIn.Checked = newsletterOptIn;
    }

    protected void CacheButton_Click(object sender, EventArgs e)
    {
        CacheManager.Clear();
        ErrorLiteral.Text = "Cache Purged";
    }
}