<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Receipt.aspx.cs" Inherits="Receipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="pageTitle">Your Receipt</div>

<b>Please print this page for your records.</b><br /><br />
<b>Order Number:</b> <%= Order.OrderNumber%><br /><br />
<b>Customer:</b> <%= Customer.FirstName %> <%= Customer.LastName %><br /><br />
<b>Ship to (if applicable):</b> <br />
<%= Order.Address %>, <br />
<%= Order.City %>, <%= State %><%= Province %>, <br /><%= Country %>, <%= Order.Zipcode %>
<br /><br />

<div class="pageTitle">Order Details</div>

        <table class="cartTblCheckout">
        <tr class="headerTbl">
            <td><b>Product</b></td>
            <td><b>Catalog No.</b></td>
            <td class="alignCenter"><b>Quantity</b></td>
            <td><b>Price</b></td>
        </tr>
        <% foreach (InvertedSoftware.ShoppingCart.DataObjects.OrderItem item in Order.OrderItems)
           {%>
           <tr>
            <td>
            <b><%= item.ProductName%></b>
            <%if (!string.IsNullOrWhiteSpace(item.DownloadURL))
              {  %>
              <a href="<%: item.DownloadURL%>" target="_blank">Download</a>
            <%} %>
             <%if (!string.IsNullOrWhiteSpace(item.DownloadKey))
              {  %>
              <br />Key: <%: item.DownloadKey %>
            <%} %>
            <% foreach (InvertedSoftware.ShoppingCart.DataObjects.OrderProductOption option in item.OptionList)
               {%>
               <br />
               <%= option.ProductOptionName%>
            <%} %>

              <% if (item.OrderProductCustomFieldList.Count > 0)
               {%>
                <br />
           <%} %>

             <% foreach (InvertedSoftware.ShoppingCart.DataObjects.OrderProductCustomField field in item.OrderProductCustomFieldList)
              {%>
               <br />
               <%= field.CustomFieldName%>: <%=field.OrderProductCustomFieldValue%>
            <%} %>


            </td>
           <td><%= item.CatalogNumber%></td>
            <td><%= item.Quantity%></td>
            <td><%= item.TotalPrice.ToString("c")%></td>
           </tr>

         
        <%} %>

  
        <tr>
             <td colspan="2" class="whiteTbl"></td>
             <td class="receiptTotals whiteTbl">
                <b>Shipping:</b><br /><br />
                <b>Tax:</b><br /><br />
                <span class="total">Total:</span>
             </td>
             <td class="whiteTbl">
             
                <%= Order.Shipping.ToString("c") %><br /><br />
                <%= Order.Tax.ToString("c") %><br /><br />
                <span class="total"><%= Order.Total.ToString("c") %></span>
             
             </td>
        </tr>
        </table>

        <br /><br />
</asp:Content>

