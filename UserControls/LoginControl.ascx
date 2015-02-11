<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginControl.ascx.cs" Inherits="UserControls_LoginControl" %>
<asp:Login ID="Login1" runat="server">
    <LayoutTemplate>
        
        <span class="error"><asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal><br /><br /></span>

        <div class="formRow clearfix">
            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Email:</asp:Label>
            <div class="formInput"><asp:TextBox ID="UserName" runat="server"></asp:TextBox></div>
            <div class="formError"><asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                        ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                        ToolTip="User Name is required." ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator></div>
        </div>

         <div class="formRow clearfix">
            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
            <div class="formInput"><asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox></div>
            <div class="formError"><asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                        ControlToValidate="Password" ErrorMessage="Password is required." 
                                        ToolTip="Password is required." ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator></div>
        </div>

        <div class="loginElements clearfix">
            
            <div><asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="ctl00$Login1" CssClass="btnLogin" /></div>
            <div><asp:CheckBox ID="RememberMe" runat="server" Text="Remember me." /></div>
        </div>

    </LayoutTemplate>
</asp:Login>
