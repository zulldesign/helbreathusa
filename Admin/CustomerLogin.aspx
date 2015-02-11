<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="CustomerLogin.aspx.cs" Inherits="Admin_CustomerLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Literal ID="MessageLiteral" runat="server"></asp:Literal><br /><br />
    Email: <asp:TextBox ID="EmailTextBox" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="UserValidation" Display="Dynamic" ControlToValidate="EmailTextBox" ErrorMessage="Email is required">
    </asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="UserValidation" Display="Dynamic" ControlToValidate="EmailTextBox" ErrorMessage="Email is not valid" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
    <br /><br />
    <asp:CheckBox ID="ActiveCheckBox" Text="Approved" runat="server" />
    <br /><br />
    <asp:Button ID="SaveButton" runat="server" Text="Save" ValidationGroup="UserValidation" OnClick="SaveButton_Click" />
    <asp:Button ID="UnblockButton" runat="server" Text="Unblock User" OnClick="UnblockButton_Click" />
</asp:Content>

