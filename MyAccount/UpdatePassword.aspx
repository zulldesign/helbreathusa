<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UpdatePassword.aspx.cs" Inherits="MyAccount_UpdatePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="pageTitle">My Account: Change Your Password</div>

<div class="accountNav">
    <a href="Orders.aspx" class="topEdge">My Orders</a>
    <a href="GiftRegistry.aspx">My Gift Registry</a>
    <a href="AccountInfo.aspx">Update Account Info</a>
    <a href="UpdatePassword.aspx" class="bottomEdge">Update Account Password</a>
</div>
<div class="accountWrap accountForms">

    <asp:ChangePassword ID="ChangePassword1" runat="server" 
        ContinueDestinationPageUrl="~/MyAccount/Default.aspx">
        <ChangePasswordTemplate>

            <div class="error">
                 <asp:CompareValidator ID="NewPasswordCompare" runat="server" 
                                        ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" 
                                        Display="Dynamic" 
                                        ErrorMessage="The Confirm New Password must match the New Password entry.<br /><br />" 
                                        ValidationGroup="ChangePassword1"></asp:CompareValidator>
                             
               <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
            </div>
            

             <div class="formRow clearfix">
                <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Password:</asp:Label>
                <div class="formInput"><asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox></div>
                <div class="formError"><asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" 
                                        ControlToValidate="CurrentPassword" ErrorMessage="Password is required." 
                                        ToolTip="Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator></div>
           </div>

           <div class="formRow clearfix">
                <asp:Label ID="NewPasswordLabel" runat="server" 
                                        AssociatedControlID="NewPassword">New Password:</asp:Label>
                <div class="formInput"><asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox></div>
                <div class="formError"><asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" 
                                        ControlToValidate="NewPassword" ErrorMessage="New Password is required." 
                                        ToolTip="New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator></div>
           </div>

            <div class="formRow clearfix">
                 <asp:Label ID="ConfirmNewPasswordLabel" runat="server" 
                                        AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label>
                <div class="formInput"><asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox></div>
                <div class="formError"> <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" 
                                        ControlToValidate="ConfirmNewPassword" 
                                        ErrorMessage="Confirm New Password is required." 
                                        ToolTip="Confirm New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator></div>
           </div>

           
           
           <div class="formRow clearfix">
               <label></label>
               <div class="formSubmit"><asp:Button ID="ChangePasswordPushButton" runat="server" 
                                        CommandName="ChangePassword" Text="Change Password" 
                                        ValidationGroup="ChangePassword1" CssClass="btnSubmit" /></div>
           </div>
        </ChangePasswordTemplate>
    </asp:ChangePassword>
 
</div>
<div class="clear"></div>

</asp:Content>

