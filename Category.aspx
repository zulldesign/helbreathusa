<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Category.aspx.cs" Inherits="Category" %>

<%@ Register src="UserControls/ProductsGridControl.ascx" tagname="ProductsGridControl" tagprefix="uc1" %>

<%@ Register src="UserControls/FeaturedProductsControl.ascx" tagname="FeaturedProductsControl" tagprefix="uc2" %>

<%@ Register src="UserControls/TagsControl.ascx" tagname="TagsControl" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="pageTitle">Products - <%: RouteData.Values["CategoryName"] %></div>

<!-- Paging -->
<div class="sortBy clearfix">
    <div>Show Per Page:</div>
    <div><select name="perPage" id="perPage" onchange="javascript:location.href='<%: ResolveClientUrl("~/Category") %>/<%: HttpUtility.UrlEncode((string)RouteData.Values["CategoryName"]) %>?PerPage=' + this.options[this.selectedIndex].value + '&Sort=<%: Request["Sort"] %>';">
        <option value="20" <%if (Request.QueryString["PerPage"] == "20") Response.Write("selected"); %>>20</option>
        <option value="50" <%if (Request.QueryString["PerPage"] == "50") Response.Write("selected"); %>>50</option>
        <option value="-1" <%if (Request.QueryString["PerPage"] == "-1") Response.Write("selected"); %>>Show All</option>
        </select></div>

<!-- End Paging -->
<!-- Sorting -->

    <div>Sort By:</div>
    <div><select name="sort" id="sort" onchange="javascript:location.href='<%: ResolveClientUrl("~/Category") %>/<%: HttpUtility.UrlEncode((string)RouteData.Values["CategoryName"]) %>?Sort=' + this.options[this.selectedIndex].value + '&PerPage=<%: Request["PerPage"] %>';">
        <option value="DontSort" <%if(Request.QueryString["Sort"] == "DontSort") Response.Write("selected"); %>>Don't Sort</option>
        <option value="LowtoHigh" <%if(Request.QueryString["Sort"] == "LowtoHigh") Response.Write("selected"); %>>Price: Low to High</option>
        <option value="HightoLow" <%if(Request.QueryString["Sort"] == "HightoLow") Response.Write("selected"); %>>Price: High to Low</option>
        <option value="Name" <%if(Request.QueryString["Sort"] == "Name") Response.Write("selected"); %>>A-Z by Name</option>
        </select></div>
</div>
<!-- End Sorting -->

<asp:Repeater ID="CategoryNavRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.Category" SelectMethod="CategoryNavRepeater_GetData" runat="server">
        <HeaderTemplate>
        </HeaderTemplate>
        <ItemTemplate>
            <a href='<%: ResolveClientUrl("~/Category") %>/<%# HttpUtility.UrlEncode(Item.CategoryName) %>'><%# Item.CategoryName %></a>
        </ItemTemplate>
        <FooterTemplate>
        </FooterTemplate>
    </asp:Repeater>
   
<uc1:ProductsGridControl ID="ProductsGrid" runat="server" />
<uc2:FeaturedProductsControl ID="FeaturedProductsControl1" runat="server" /><br />
<uc3:TagsControl ID="TagsControl1" runat="server" />

<div class="right">
    <a href="<%: ResolveClientUrl("~/Data/RSS.ashx") %>?Category=<%: HttpUtility.UrlEncode((string)RouteData.Values["CategoryName"]) %>">RSS</a>  <a href="<%: ResolveClientUrl("~/Data/RSS.ashx") %>?Category=<%: Server.UrlEncode((string)RouteData.Values["CategoryName"]) %>">Atom</a>
</div>
</asp:Content>

