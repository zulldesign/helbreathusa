<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="News.aspx.cs" Inherits="News" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
  
    <div class="pageTitle">News</div>

    <asp:Repeater ID="NewsRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.NewsItem" SelectMethod="NewsRepeater_GetData" runat="server">
    <HeaderTemplate>
      
    </HeaderTemplate>
    <ItemTemplate>
    <%# Item.DatePublished.ToShortDateString() %>
    <b><a href="<%: ResolveClientUrl("~/NewsItem") %>/<%# HttpUtility.UrlEncode(Item.NewsItemName)%>"><%# Item.NewsItemName %></a></b><br /><br />
    <%# Eval("NewsItemText")%>...<br /><br /><br />
    </ItemTemplate>
 
    <FooterTemplate>
       
    </FooterTemplate>
</asp:Repeater>

<%: Scripts.Render("~/bundles/Pager") %>
<div id="PagerDiv"></div>
</asp:Content>

