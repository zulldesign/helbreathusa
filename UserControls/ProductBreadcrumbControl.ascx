<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductBreadcrumbControl.ascx.cs" Inherits="UserControls_ProductBreadcrumbControl" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.DataObjects" %>
<%@ OutputCache Duration="100" VaryByParam="none" VaryByCustom="ProductName" %>
<asp:Repeater ID="BreadcrumbRepeater" SelectMethod="BreadcrumbRepeater_GetData" runat="server">
<HeaderTemplate>
 <div class="noImageSpace"></div>
 <div class="onProductPage pageTitle featuredTitle">Browse for more products in the same category</div>
 <div class="categoryTree">
</HeaderTemplate>
<ItemTemplate><br />
<asp:Repeater ID="PathRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.Category" DataSource='<%# GetParentCategories(Convert.ToInt32(Container.DataItem)) %>' runat="server">
<ItemTemplate>
    <a href='<%: ResolveClientUrl("~/Category/") %><%# HttpUtility.UrlEncode(Item.CategoryName) %>'><%# Item.CategoryName %></a> > 
</ItemTemplate>
</asp:Repeater>
</ItemTemplate>
<FooterTemplate>
</div>
</FooterTemplate>
</asp:Repeater>
