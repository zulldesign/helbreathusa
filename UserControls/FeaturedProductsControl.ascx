<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FeaturedProductsControl.ascx.cs" Inherits="UserControls_FeaturedProductsControl" %>
<%@ OutputCache Duration="100" VaryByParam="None" VaryByCustom="CategoryName" %>
<asp:Repeater ID="ProductsSummaryRepeater" runat="server" 
	ItemType="InvertedSoftware.ShoppingCart.DataObjects.FeaturedProduct" SelectMethod="ProductsSummaryRepeater_GetData"
	onprerender="ProductsSummaryRepeater_PreRender">
	<HeaderTemplate>
		<div class="pageTitle featuredTitle">Featured</div>
		<div class="featured clearfix">
	</HeaderTemplate>
	<ItemTemplate>
		<div class="featuredWrap clearfix">
			<figure class="cap-bot">
				<a class="productImage" title="<%# Item.ProductName %>" href="<%: ResolveClientUrl("~/Product") %>/<%# HttpUtility.UrlEncode(Item.ProductName) %>"><img src='<%: ResolveClientUrl("~/ProductImages") %>/<%# Item.Thumbnail %>' alt='<%# Item.ProductName %>' /></a>
				<figcaption><a href="<%: ResolveClientUrl("~/Product") %>/<%# HttpUtility.UrlEncode(Item.ProductName) %>"><%# Item.ProductName %>.</a></figcaption>
			</figure>
		  </div>
	</ItemTemplate>
	<FooterTemplate>
	  </div>
	</FooterTemplate>
</asp:Repeater>
