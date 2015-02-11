<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="NewsItem.aspx.cs" Inherits="NewsItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
     <div class="pageTitle">News</div>

<b><%: CurrentNewsItem.NewsItemName%></b><br /><br />
<%= CurrentNewsItem.NewsItemText%><br /><br />
<a href="~/News/" runat="server"><< Back to news</a>
</asp:Content>

