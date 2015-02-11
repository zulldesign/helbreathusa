<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AccountInfo.aspx.cs" Inherits="MyAccount_AccountInfo" %>

<%@ Register src="../UserControls/AddressControl.ascx" tagname="AddressControl" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="pageTitle">My Account: Update Account Info</div>

<div class="accountNav">
    <a href="Orders.aspx" class="topEdge">My Orders</a>
    <a href="GiftRegistry.aspx">My Gift Registry</a>
    <a href="AccountInfo.aspx">Update Account Info</a>
    <a href="UpdatePassword.aspx" class="bottomEdge">Update Account Password</a>
</div>
<div class="accountWrap  accountForms">


<asp:UpdatePanel ID="UpdatePanel1" runat="server">
 <ContentTemplate>
            
           <div class="errors">
           <asp:ValidationSummary ID="CustomerValidationSummary" runat="server" />
           <asp:Label ID="MessageLabel" runat="server"></asp:Label>
           </div>

           <div class="formRow clearfix">
                <label>Company:</label>
                <div class="formInput"><asp:TextBox ID="ComapnyTextBox" runat="server"></asp:TextBox></div>
                <div class="formError"></div>
           </div>

           <div class="formRow clearfix">
                <label>First Name:</label>
                <div class="formInput"><asp:TextBox ID="FirstNameTextBox" runat="server"></asp:TextBox></div>
                <div class="formError"><asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" 
                    ControlToValidate="FirstNameTextBox" runat="server" 
                    ErrorMessage="First Name is Required">*</asp:RequiredFieldValidator></div>
           </div>

           <div class="formRow clearfix">
                <label>Last Name:</label>
                <div class="formInput"><asp:TextBox ID="LastNameTextBox" runat="server"></asp:TextBox></div>
                <div class="formError"><asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" 
                    ControlToValidate="LastNameTextBox" runat="server" 
                    ErrorMessage="Last Name is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator></div>
           </div>
  
           <uc1:AddressControl ID="AddressControl1" runat="server" />

           <div class="formRow clearfix">
                <label>Day Phone:</label>
                <div class="formInput"><asp:TextBox ID="DayPhoneTextBox" runat="server"></asp:TextBox></div>
                <div class="formError"></div>
           </div>

           <div class="formRow clearfix">
                <label>Evening Phone:</label>
                <div class="formInput"><asp:TextBox ID="EveningPhoneTextBox" runat="server"></asp:TextBox></div>
                <div class="formError"><asp:RequiredFieldValidator ID="EveningPhoneRequiredFieldValidator" 
                    ControlToValidate="EveningPhoneTextBox" runat="server" 
                    ErrorMessage="Evening Phone is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator></div>
           </div>

           <div class="formRow clearfix">
                <label>Cell Phone:</label>
                <div class="formInput"><asp:TextBox ID="CellPhoneTextBox" runat="server"></asp:TextBox></div>
                <div class="formError"></div>
           </div>

            
            <div class="formRow clearfix">
                <label>Fax:</label>
                <div class="formInput"><asp:TextBox ID="FaxTextBox" runat="server"></asp:TextBox></div>
                <div class="formError"></div>
           </div>

            <div class="formRow clearfix">
                <label></label>
                <div class="formSubmit"><asp:Button ID="SaveButton" runat="server" CssClass="btnSubmit" Text="Save" 
                onclick="SaveButton_Click" /></div>
           </div>

       
      
            
        </ContentTemplate>
    </asp:UpdatePanel>

</div>
<div class="clear"></div>
</asp:Content>

