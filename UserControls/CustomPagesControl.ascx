<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CustomPagesControl.ascx.cs" Inherits="UserControls_CustomPagesControl" %>
<asp:Repeater ID="NavRepeater" SelectMethod="NavRepeater_GetData" runat="server">
<HeaderTemplate>
</HeaderTemplate>
<ItemTemplate>
	<a href="<%: ResolveClientUrl("~/Pages/") %><%# Container.DataItem %>"><%# Container.DataItem %></a>
</ItemTemplate>
<FooterTemplate>
</FooterTemplate>
</asp:Repeater>	