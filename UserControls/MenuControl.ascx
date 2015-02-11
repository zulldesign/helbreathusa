<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MenuControl.ascx.cs" Inherits="UserControls_MenuControl" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.BusinessLayer.Controls" %>

<!-- Navigation -->
<div class="nav clearfix">
	<a href="~/Default.aspx" class="navHome" runat="server">Home</a>
	<a id="productNav" class="navProducts">Products</a>
	<a href="~/ShoppingCart.aspx" class="navCart" runat="server">My Cart (<%: ((BasePage)Page).Cart.CartItems.Count %>)</a>
	<a href="~/MyAccount/Default.aspx" class="navAccount" runat="server">My Account</a>
	<a href="~/SearchGiftRegistries.aspx" class="navGift" runat="server">Gift Registry</a>
	<a href="~/Register.aspx" class="navRegister" runat="server">Register</a>
	<% if (isNewsMenuItemVisible()) {  %>
	<a href="~/News/" class="navNews" runat="server">News</a>
	<%} %>
</div><!-- end Navigation -->


				
<asp:Repeater ID="CategoryRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.Category" SelectMethod="CategoryRepeater_GetData" runat="server">
<HeaderTemplate>

<!-- Products -->
<div id="productList">
	<div class="menuTop"></div>
	<div class="menuWrap">

</HeaderTemplate>
<ItemTemplate>
	<a href='<%: ResolveClientUrl("~/Category/") %><%# HttpUtility.UrlEncode(Item.CategoryName) %>'><%# Item.CategoryName %></a>
	<div class="sep"></div>
</ItemTemplate>
<FooterTemplate>

	</div>
	<div class="menuBottom"></div>
</div><!-- end Products -->

</FooterTemplate>
</asp:Repeater>	