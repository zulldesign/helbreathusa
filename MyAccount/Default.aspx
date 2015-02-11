<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="MyAccount_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="pageTitle">My Account</div>

<div class="accountNav">
    <a href="Orders.aspx" class="topEdge">My Orders</a>
    <a href="GiftRegistry.aspx">My Gift Registry</a>
    <a href="AccountInfo.aspx">Update Account Info</a>
    <a href="UpdatePassword.aspx" class="bottomEdge">Update Account Password</a>
</div>
<div class="accountWrap">
    Welcome to your account. 
    <br /><br />
    Please use the links to the left to navigate through your account options.
</div>
<div class="clear"></div>
</asp:Content>

