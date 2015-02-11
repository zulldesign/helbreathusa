<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductsSearchControl.ascx.cs" Inherits="UserControls_ProductsSearchControl" %>
<div class="totalRecords">Total of: <b><%: TotalRecords%> Products</b></div>

    <div class="product clearfix">
    <asp:Literal ID="MessageLiteral" runat="server"></asp:Literal>
    <asp:Repeater ID="ProductsRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.Product" runat="server" 
            onitemcommand="ProductsRepeater_ItemCommand" 
            onitemdatabound="ProductsRepeater_ItemDataBound">
    <HeaderTemplate>
        
    </HeaderTemplate>
    <ItemTemplate>
    
        <asp:HiddenField ID='ProductIDHiddenField' Value='<%# Item.ProductID %>' runat='server' />
        <asp:HiddenField ID='ProductLinkHiddenField' Value='<%# Eval("ProductLink") %>' runat='server' />
            
            <div class="productWrap clearfix">
                <a class="productImage" title="<%# Item.ProductName %>" href="<%: ResolveClientUrl("~/Product/") %><%# HttpUtility.UrlEncode(Item.ProductName) %>"><img src='<%: ResolveClientUrl("~/ProductImages/") %>/<%# Item.Thumbnail %>' alt='<%# Item.ProductName %>' border="0" width="75" height="75" /></a>
                <div class="productInfo">
                    <asp:Label ID="ProductNameLabel" runat="server" CssClass="title" Text='<%# Item.ProductName %>'></asp:Label>
                    <%# Item.Description %> <a href="<%: ResolveClientUrl("~/Product/") %><%# HttpUtility.UrlEncode(Item.ProductName) %>">More...</a>
                    <br /><br />
                    <asp:Button ID="AddButton" runat="server" CssClass="addCart" Text="<%# InvertedSoftware.ShoppingCart.Localization.FormsResources.Buy %>" CommandName="AddToCart" />
                </div>
           </div>
        
    </ItemTemplate>
 
    <FooterTemplate>
       
    </FooterTemplate>
</asp:Repeater>

</div>
<%: Scripts.Render("~/bundles/Pager") %>
<div id="PagerDiv"></div>