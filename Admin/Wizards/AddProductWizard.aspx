<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="AddProductWizard.aspx.cs" Inherits="Admin_Wizards_AddProductWizard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2 class="DDSubHeader">Please this form to add a new product to your store.</h2>
    
    <div class="DDValidator"><asp:Literal ID="MessageLiteral" runat="server"></asp:Literal></div><br />
    <table id="detailsTable" class="DDDetailsTable" cellpadding="6">
        <tr class="td">
		    <td class="DDLightHeader">Catalog Number:</td>
            <td><asp:TextBox ID="CatalogNumber" class="DDTextBox" MaxLength="50" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="CatalogNumberRequiredFieldValidator" ControlToValidate="CatalogNumber" runat="server" ErrorMessage="Required">*</asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CatalogNumberCustomValidator" runat="server" ControlToValidate="CatalogNumber" ErrorMessage="Catalog Number already exists in the database" OnServerValidate="CatalogNumberCustomValidator_ServerValidate"></asp:CustomValidator>
            </td>
		</tr>
         <tr class="td">
		    <td class="DDLightHeader">Product Name:</td>
            <td><asp:TextBox ID="ProductName" class="DDTextBox" MaxLength="50" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="ProductNameRequiredFieldValidator" ControlToValidate="ProductName" runat="server" ErrorMessage="Required">*</asp:RequiredFieldValidator>
            <asp:CustomValidator ID="ProductNameCustomValidator" runat="server" ControlToValidate="ProductName" ErrorMessage="Product Name already exists in the database" OnServerValidate="ProductNameCustomValidator_ServerValidate"></asp:CustomValidator></td>
		</tr>
         <tr class="td">
		    <td class="DDLightHeader">Add this product in category</td>
            <td><asp:DropDownList ID="CategoryDropDownList" class="DDTextBox" ItemType="InvertedSoftware.ShoppingCart.DataLayer.Models.Category" SelectMethod="CategoryDropDownList_GetData" DataTextField="CategoryName" DataValueField="CategoryID" runat="server"></asp:DropDownList></td>
		</tr>
         <tr class="td">
		    <td class="DDLightHeader">Description:</td>
            <td><asp:TextBox ID="Description" class="DDTextBox" TextMode="MultiLine" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="DescriptionRequiredFieldValidator" ControlToValidate="Description" runat="server" ErrorMessage="Required">*</asp:RequiredFieldValidator></td>
		</tr>
         <tr class="td">
		    <td class="DDLightHeader">Price:</td>
            <td><asp:TextBox ID="Price" TextMode="Number" step="any" min="0" class="DDTextBox" ClientIDMode="Static" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="PriceRequiredFieldValidator" ControlToValidate="Price" runat="server" ErrorMessage="Required">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="PriceRegularExpressionValidator" runat="server" ControlToValidate="Price" Display="Dynamic" ErrorMessage="Please enter a number in the form of X.XX" ValidationExpression="^\d+(\.\d\d)?$"></asp:RegularExpressionValidator>
             </td>
		</tr>
         <tr class="td">
		    <td class="DDLightHeader">Sale Price:</td>
            <td><asp:TextBox ID="SalePrice" ClientIDMode="Static" step="any" min="0" class="DDTextBox" TextMode="Number" runat="server"></asp:TextBox></td>
		</tr>
         <tr class="td">
            <td class="DDLightHeader" colspan="2"><asp:CheckBox ID="IsSubscription" Text="Subscription" runat="server" /></td>
		</tr>
         <tr class="td">
		    <td class="DDLightHeader">Subscription Setup Fee:</td>
            <td><asp:TextBox ID="SubscriptionSetupFee" ClientIDMode="Static" class="DDTextBox" TextMode="Number" step="any" min="0" runat="server"></asp:TextBox></td>
		</tr>
         <tr class="td">
            <td class="DDLightHeader" colspan="2"><asp:CheckBox ID="IsDownloadable" Text="Downloadable" runat="server" /></td>
		</tr>
         <tr class="td">
            <td class="DDLightHeader" colspan="2"><asp:CheckBox ID="IsDownloadKeyRequired" Text="Download Key Required" runat="server" /></td>
		</tr>
         <tr class="td">
            <td class="DDLightHeader" colspan="2"><asp:CheckBox ID="IsDownloadKeyUnique" Text="Download Key is Unique" runat="server" /></td>
		</tr>
         <tr class="td">
		    <td class="DDLightHeader">Download URL:</td>
            <td> <asp:TextBox ID="DownloadURL" class="DDTextBox" runat="server"></asp:TextBox></td>
		</tr>
        <tr class="td">
            <td class="DDLightHeader" colspan="2"><asp:CheckBox ID="IsReviewEnabled" Text="Allow product Reviews" runat="server" /></td>
		</tr>
        <tr class="td">
		    <td class="DDLightHeader">Total Reviews to show on Google Search:</td>
            <td> <asp:TextBox ID="TotalReviewCount" class="DDTextBox" TextMode="Number" step="any" min="0" ClientIDMode="Static" runat="server"></asp:TextBox></td>
		</tr>
        <tr class="td">
		    <td class="DDLightHeader">Rating Score to show on Google Search:</td>
            <td> <asp:RadioButtonList ID="RatingScore" runat="server" class="DDTextBox" RepeatDirection="Horizontal">
                    <asp:ListItem Value="1">One</asp:ListItem>
                    <asp:ListItem Value="2">Two</asp:ListItem>
                    <asp:ListItem Value="3">Three</asp:ListItem>
                    <asp:ListItem Value="4">Four</asp:ListItem>
                    <asp:ListItem Value="5">Five</asp:ListItem>
                </asp:RadioButtonList></td>
		</tr>
        <tr class="td">
            <td class="DDLightHeader" colspan="2"><asp:CheckBox ID="Active" Text="Active" runat="server" /></td>
		</tr>
        <tr class="td">
		    <td class="DDLightHeader">Add Multiple Images to your product:</td>
            <td><asp:FileUpload ID="ProductImagesUpload" AllowMultiple="true" runat="server" /></td>
		</tr>
        <tr class="td">
            <td colspan="2"><asp:Button ID="SaveButton" runat="server" Text="Add Product" OnClick="SaveButton_Click" /></td>
		</tr>
        </table>
</asp:Content>

