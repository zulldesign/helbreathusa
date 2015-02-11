<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Async="true" CodeFile="Checkout.aspx.cs" Inherits="Checkout" %>
<%@ Register src="UserControls/AddressControl.ascx" tagname="AddressControl" tagprefix="uc1" %>

<%@ Register src="UserControls/PaymentControl.ascx" tagname="PaymentControl" tagprefix="uc2" %>

<%@ Register src="UserControls/CartSummaryControl.ascx" tagname="CartSummaryControl" tagprefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <script type="text/javascript">
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

        function BeginRequestHandler(sender, args) {
            var postbackElem = args.get_postBackElement();
            postbackElem.disabled = true;
        }

        function EndRequestHandler(sender, args) {
            var label = $get('errorMessage');
            if (args.get_error() != undefined) {
                args.set_errorHandled(true);
                label.innerHTML = '<b>' + args.get_error().message + '</b>';
            }
            else {
                label.innerHTML = '';
            }
        }
    </script>
    <span id="errorMessage"></span>
 
   
    <asp:UpdatePanel ID="CheckoutUpdatePanel" runat="server">
        <ContentTemplate>
            
            <asp:Label ID="MessageLabel" runat="server"></asp:Label>

    

    <div class="pageTitle">
    <asp:LoginView ID="LoginView1" runat="server">
        <AnonymousTemplate>
            Returning Customer? <a href="Login.aspx">Login here to your account</a>
        </AnonymousTemplate>
        <LoggedInTemplate>
            Welcome back <asp:LoginName ID="LoginName1" runat="server" />
        </LoggedInTemplate>
        </asp:LoginView>
    </div>

    <b>Please check your cart below:</b>
    <br /><br />

    <table class="cartTblCheckout">
    <tr class="headerTbl">
        <td class="alignLeft">Products</td>
        <td class="alignCenter">Quanity</td>
    </tr>
    <uc3:CartSummaryControl ID="CartSummaryControl1" runat="server" />
    <tr>
        <td colspan="2"  class="whiteTbl alignRight">Discounts: <b><%= Cart.Discounts.ToString("c")%></b></td>
    </tr>
    <tr>
        <td colspan="2" class="whiteTbl alignRight">Subtotal: <b><%= Cart.Subtotal.ToString("c") %></b></td>
    </tr>
    <tr>
        <td colspan="2" class="whiteTbl alignRight">Shipping: <b><%= Cart.Shipping.ToString("c") %></b></td>
    </tr>
    <tr>
        <td colspan="2" class="whiteTbl alignRight">Tax:<b> <%= Cart.Tax.ToString("c") %></b></td>
    </tr>
    <tr>
        <td colspan="2" class="whiteTbl alignRight total">Total: <%= Cart.Total.ToString("c") %></td>
    </tr>
    </table>

    <div class="pageTitle">Please fillout the form below to place your order.</div>

    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
    <div class="clear"></div>
    <br /><br />

    <div class="checkoutCol">
        <div class="pageTitleSmall">Billing Information</div>

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
                    ErrorMessage="First Name is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator></div>
        </div>

        <div class="formRow clearfix">
            <label>Last Name:</label>
            <div class="formInput"><asp:TextBox ID="LastNameTextBox" runat="server"></asp:TextBox></div>
            <div class="formError"><asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" 
                    ControlToValidate="LastNameTextBox" runat="server" 
                    ErrorMessage="Last Name is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator></div>
        </div>

        <uc1:AddressControl ID="BillingAddressControl" runat="server" />
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
                    ErrorMessage="Email Address already exists. Please login or enter a different Email Address." ControlToValidate="EmailTextBox" 
                    Display="Dynamic" onservervalidate="EmailCustomValidator_ServerValidate" 
                    SetFocusOnError="True">*</asp:CustomValidator></div>
        </div>

    </div>

    <div class="checkoutCol">
        <div class="pageTitleSmall">Shipping Information</div>

        <asp:CheckBox ID="ShippingCheckBox" 
            Text="Shipping Address Same As Billing Address" Checked="true" AutoPostBack="true" runat="server" 
            oncheckedchanged="ShippingCheckBox_CheckedChanged" />
            <br /><br />

        <uc1:AddressControl ID="ShippingAddressControl" Enabled="false" runat="server" />

        <div class="formRow clearfix">
            <label>Shipping Method:</label>
            <div class="formInput">
                <asp:Panel ID="ShippingPanel" runat="server">
                    <asp:DropDownList ID="ShippingLookupDataDropDownList" runat="server" AutoPostBack="True" 
                        onselectedindexchanged="ShippingLookupDataDropDownList_SelectedIndexChanged">
                    </asp:DropDownList>
                </asp:Panel>
                <asp:Literal ID="NoShippingLiteral" Visible="false" runat="server"></asp:Literal>
            </div>
            <div class="formError"><asp:RequiredFieldValidator ID="ShippingRequiredFieldValidator" 
                    ControlToValidate="ShippingLookupDataDropDownList" runat="server" 
                    ErrorMessage="Please select Shipping Method">*</asp:RequiredFieldValidator></div>
        </div>

         <div class="formRow clearfix">
            <label>Comments:</label>
            <div class="formTextArea"><asp:TextBox ID="CommentsTextBox" TextMode="MultiLine" MaxLength="400" Rows="10" runat="server"></asp:TextBox></div>
            <div class="formError"></div>
        </div>



    </div>

    <div class="checkoutCol">
        <div class="pageTitleSmall">Payment Information</div>

        <uc2:PaymentControl ID="PaymentControl1" runat="server" />
        <asp:Button ID="BuyButton" runat="server" Text="complete purchase" onclick="BuyButton_Click" CssClass="btnComplete" />

    </div>

    <div class="clear"></div>
</ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>

