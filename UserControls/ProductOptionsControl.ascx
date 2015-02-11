<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductOptionsControl.ascx.cs" Inherits="UserControls_ProductOptionsControl" %>
<asp:Repeater ID="GroupsRepeater" runat="server"  
    onitemdatabound="GroupsRepeater_ItemDataBound">
<HeaderTemplate>
    <table>
</HeaderTemplate>
<ItemTemplate>
<tr>
    <td class="customFields" align="left"><asp:Label ID="GroupLabel" Text='<%# Eval("Key") %>' runat=server></asp:Label></td>
    <td class="customFields" align="left"><asp:DropDownList ID="OptionDropDownList" runat="server" onchange="javascript:resetInventoryChecked();"></asp:DropDownList>
    </td>
</tr>
</ItemTemplate>
<FooterTemplate>
    </table>
</FooterTemplate>
</asp:Repeater>
