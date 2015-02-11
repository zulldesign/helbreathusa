<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CartSummaryControl.ascx.cs" Inherits="UserControls_CartSummaryControl" %>
<asp:Repeater ID="CartSummaryRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.CartItem" SelectMethod="CartSummaryRepeater_GetData" runat="server">
<HeaderTemplate>
    
</HeaderTemplate>
<ItemTemplate>
<tr>
    <td class="alignLeft" ><a href='<%: ResolveClientUrl("~/Product/") %><%# HttpUtility.UrlEncode(Item.ProductName) %>' target="_blank"><%# Item.ProductName %></a></td>
    <td class="alignCenter"><%# Item.Quantity %></td>
</tr>
</ItemTemplate>
<FooterTemplate>
  
</FooterTemplate>
</asp:Repeater>
