<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TagsControl.ascx.cs" Inherits="UserControls_TagsControl" %>
<%@ OutputCache Duration="30" VaryByParam="none" %>
<asp:Repeater ID="TagsRepeater" SelectMethod="TagsRepeater_GetData" runat="server" 
    onprerender="TagsRepeater_PreRender">
    <HeaderTemplate>
        <div class="tags">
            <div class="tagHead">Tags</div>
            <div class="tagBody">
    </HeaderTemplate>
    <ItemTemplate>
        <a href="<%: ResolveClientUrl("~/Search.aspx") %>?Tag=<%# HttpUtility.UrlEncode(Convert.ToString(Container.DataItem)) %>"><%# Container.DataItem %></a>
    </ItemTemplate>
    <FooterTemplate>
            </div>
        </div>
    </FooterTemplate>
</asp:Repeater>

