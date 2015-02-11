<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CustomFieldsControl.ascx.cs" Inherits="UserControls_CustomFieldsControl" %>
<asp:Repeater ID="CustomFieldsRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.CustomField" runat="server" 
    onitemdatabound="CustomFieldsRepeater_ItemDataBound">
<HeaderTemplate>
    
</HeaderTemplate>
<ItemTemplate>
    <table>
    <tr>
        <td class="customFields" align="left"><asp:Label ID="FieldNameLabel" runat="server" Text='<%# Item.CustomFieldName %>'></asp:Label>:</td>
        <td id="CustomField" align="left" runat="server" class="customFields"></td>
    </tr>
    </table>
</ItemTemplate>
<FooterTemplate>
    
</FooterTemplate>
</asp:Repeater>
