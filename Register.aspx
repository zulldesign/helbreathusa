<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Async="true" CodeFile="Register.aspx.cs" Inherits="Register" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.Localization" %>
<%@ Register src="UserControls/AddressControl.ascx" tagname="AddressControl" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="pageTitle">Register</div>

<div class="accountForms clearfix">

    <b><%: FormsResources.RegisterMessage %></b>
    <br /><br />
    <div><asp:ValidationSummary ID="ValidationSummary1" runat="server" /></div>
    <div><asp:Label ID="MessageLabel" runat="server"></asp:Label></div>
    
    <div class="formRow">
        <br />
        <div class="formRow clearfix">
            <label>Company:</label>
            <div class="formInput"><asp:TextBox ID="ComapnyTextBox" runat="server"></asp:TextBox></div>
            <div class="formError">
            </div>
        </div>

        <div class="formRow clearfix">
            <label>First Name:</label>
            <div class="formInput"><asp:TextBox ID="FirstNameTextBox" runat="server"></asp:TextBox></div>
            <div class="formError"><asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" 
                        ControlToValidate="FirstNameTextBox" runat="server" 
                        ErrorMessage="First Name is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="formRow clearfix">
            <label>Last Name:</label>
            <div class="formInput"><asp:TextBox ID="LastNameTextBox" runat="server"></asp:TextBox></div>
            <div class="formError"><asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" 
                        ControlToValidate="LastNameTextBox" runat="server" 
                        ErrorMessage="Last Name is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
        </div>

          <div class="formRow clearfix">
            <label>Day Phone:</label>
            <div class="formInput"><asp:TextBox ID="DayPhoneTextBox" runat="server"></asp:TextBox></div>
            <div class="formError">
            </div>
        </div>

        <div class="formRow clearfix">
            <label>Evening Phone:</label>
            <div class="formInput"><asp:TextBox ID="EveningPhoneTextBox" runat="server"></asp:TextBox></div>
            <div class="formError"><asp:RequiredFieldValidator ID="EveningPhoneRequiredFieldValidator" 
                        ControlToValidate="EveningPhoneTextBox" runat="server" 
                        ErrorMessage="Evening Phone is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="formRow clearfix">
            <label>Cell Phone:</label>
            <div class="formInput"><asp:TextBox ID="CellPhoneTextBox" runat="server"></asp:TextBox></div>
            <div class="formError">
            </div>
        </div>

         <div class="formRow clearfix">
                    <label></label>
                    <div class="formSubmit"><asp:Button ID="RegisterButton" runat="server" Text="Register" CssClass="btnSubmit" 
                        onclick="RegisterButton_Click" /></div>
               </div>
        

    </div>
    <div class="formRow">
         <br />
         <uc1:AddressControl ID="BillingAddressControl" runat="server" />

         <div class="formRow clearfix">
            <label>Fax:</label>
            <div class="formInput"><asp:TextBox ID="FaxTextBox" runat="server"></asp:TextBox></div>
            <div class="formError">
            </div>
        </div>

         <div class="formRow clearfix">
            <label>Email:</label>
            <div class="formInput"><asp:TextBox ID="EmailTextBox" runat="server"></asp:TextBox></div>
            <div class="formError"><asp:RequiredFieldValidator ID="EmailRequiredFieldValidator" 
                        ControlToValidate="EmailTextBox" runat="server" 
                        ErrorMessage="Email is Required" Display="Dynamic" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="EmailRegularExpressionValidator" 
                        runat="server" ControlToValidate="EmailTextBox" Display="Dynamic" 
                        ErrorMessage="Email not Valid" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                        SetFocusOnError="True">*</asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="EmailCustomValidator" runat="server" 
                        ErrorMessage="The Email Address you entered already exists in the system. Please sign into your account to continue or enter a different Email Address." ControlToValidate="EmailTextBox" 
                        Display="Dynamic" onservervalidate="EmailCustomValidator_ServerValidate" 
                        SetFocusOnError="True">*</asp:CustomValidator>
            </div>
        </div>


    </div>


</div>
</asp:Content>

