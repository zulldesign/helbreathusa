<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Import Namespace="InvertedSoftware.ShoppingCart.Common" %>

<%@ Import Namespace="InvertedSoftware.ShoppingCart.DataLayer.Cache" %>

<%@ Register src="UserControls/FeaturedProductsControl.ascx" tagname="FeaturedProductsControl" tagprefix="uc1" %>

<%@ Register src="UserControls/TagsControl.ascx" tagname="TagsControl" tagprefix="uc2" %>



<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">

        
        <div class="pageTitle">Welcome to <%: StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreName) %></div>

        <%= CacheManager.GetCustomPage(Utils.MAIN_PAGE_TEXT_KEY).CustomPageText%>

        <uc1:FeaturedProductsControl ID="FeaturedProductsControl1" runat="server" />

        <uc2:TagsControl ID="TagsControl1" runat="server" />


</asp:Content>
