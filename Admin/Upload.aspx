<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="Upload.aspx.cs" Inherits="Admin_Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="title"><asp:Label ID="MessageLabel" runat="server" Text="Please select image to upload"></asp:Label></div>

<table class="uploadTbl">
<tr>
    <td align="right">Upload image</td>
    <td>
        <asp:FileUpload ID="ProductFileUpload" AllowMultiple="true" runat="server" Style="width:200px;" /></td>
</tr>
<tr>
    <td></td>
    <td >
        <asp:Button ID="UploadButton" runat="server" Text="Upload" 
            onclick="UploadButton_Click" /></td>
</tr>
</table>
</asp:Content>

