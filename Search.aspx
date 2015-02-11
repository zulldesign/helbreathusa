<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

<%@ Register src="UserControls/ProductsSearchControl.ascx" tagname="ProductsSearchControl" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    
<div class="pageTitle">Search</div>

<div class="searchTerm">Search Term: "<b><%: Request.QueryString["Keyword"]%></b>"</div>


<uc1:ProductsSearchControl ID="ProductsGrid" runat="server" />
</asp:Content>

