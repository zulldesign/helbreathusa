<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RelatedProductsControl.ascx.cs" Inherits="UserControls_RelatedProductsControl" %>
<%@ OutputCache Duration="100" VaryByParam="none" VaryByCustom="ProductName" %>
<asp:Repeater ID="ProductsSummaryRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.RelatedProduct" SelectMethod="ProductsSummaryRepeater_GetData" runat="server" 
	onprerender="ProductsSummaryRepeater_PreRender">
	<HeaderTemplate>
		<div class="pageTitle featuredTitle">You might also like</div>
		<div class="featured clearfix">
	</HeaderTemplate>
	<ItemTemplate>
		<div class="featuredWrap clearfix">
			<figure class="cap-bot">
				<a class="productImage" title="<%# Item.ProductName %>" href="<%: ResolveClientUrl("~/Product") %>/<%# HttpUtility.UrlEncode(Item.ProductName) %>" target="_top"><img src='<%: ResolveClientUrl("~/ProductImages") %>/<%# Item.Thumbnail %>' alt='<%# Item.ProductName %>' /></a>
				<figcaption><a href="<%: ResolveClientUrl("~/Product") %>/<%# HttpUtility.UrlEncode(Item.ProductName) %>" target="_top"><%# Item.ProductName %>.</a></figcaption>
			</figure>
		  </div>
	</ItemTemplate>
	<FooterTemplate>
		</div>
	</FooterTemplate>
</asp:Repeater>