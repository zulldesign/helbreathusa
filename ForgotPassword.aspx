<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Async="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
     <div class="pageTitle">Forgot Your Password?</div>

    <div class="loginWrap">
        Enter your User Name to receive your password.
        <br /><br />

        <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" OnSendingMail="PasswordRecovery1_SendingMail">
            <UserNameTemplate>

            <span class="error"><asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal><br /></span>

            <div class="formRow clearfix">
                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                <div class="formInput"><asp:TextBox ID="UserName" runat="server"></asp:TextBox></div>
                <div class="formError"><asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                            ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                            ToolTip="User Name is required." ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator></div>
            </div>
              
            <div class="loginElements clearfix">
                
                <div><asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Submit" CssClass="btnSubmit"
                                                ValidationGroup="PasswordRecovery1" /></div>
            </div>
                                                                

        </UserNameTemplate>
    </asp:PasswordRecovery>

    </div>
</asp:Content>

