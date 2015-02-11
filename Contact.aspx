<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Async="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
      <script type="text/javascript">
          Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);

          function BeginRequestHandler(sender, args) {
              var postbackElem = args.get_postBackElement();
              postbackElem.disabled = true;
          }
</script>


    <div class="pageTitle">Contact Us</div>

    <div class="accountForms oneRowForm clearfix">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>

       <asp:Label ID="MessageLabel" runat="server"></asp:Label>
       <br /><br />
       <div class="error"><asp:ValidationSummary ID="MainValidationSummary" runat="server" /></div>

   

        <div class="formRow clearfix">
            <label>Name:</label>
            <div class="formInput"><asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox></div>
            <div class="formError"><asp:RequiredFieldValidator ID="NameRequiredFieldValidator" 
                    ControlToValidate="NameTextBox" runat="server" 
                    ErrorMessage="Name is Required" Display="Dynamic" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="clear"></div>

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
            </div>
        </div>

        <div class="clear"></div>

        <div class="formRow clearfix">
            <label>Phone Number:</label>
            <div class="formInput"><asp:TextBox ID="PhoneTextBox" runat="server"></asp:TextBox></div>
            <div class="formError">
            </div>
        </div>

        <div class="clear"></div>

         <div class="formRow clearfix">
            <label>Subject:</label>
            <div class="formInput"> <asp:DropDownList ID="SubjectDropDownList" runat="server">
            <asp:ListItem Text="Other" Value="Other" Selected="True"></asp:ListItem>
        </asp:DropDownList></div>
            <div class="formError"><asp:RequiredFieldValidator ID="SubjectRequiredFieldValidator" 
                    ControlToValidate="SubjectDropDownList" runat="server" 
                    ErrorMessage="Subject is Required" Display="Dynamic" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="clear"></div>

        <div class="formRow clearfix">
            <label>Order Number:</label>
            <div class="formInput"><asp:TextBox ID="OrderNumberTextBox" runat="server"></asp:TextBox></div>
            <div class="formError">
            </div>
        </div>

        <div class="clear"></div>

        <div class="formRow clearfix">
            <label>Where did you hear about us?</label>
            <div class="formInput"><asp:TextBox ID="AboutTextBox" runat="server"></asp:TextBox></div>
            <div class="formError">
            </div>
        </div>

        <div class="clear"></div>

         <div class="formRow clearfix">
            <label>Comments:</label>
             <div class="formTextArea"><asp:TextBox ID="CommentsTextBox" TextMode="MultiLine" Rows="10" runat="server"></asp:TextBox></div>
            <div class="formError">
            </div>
        </div>

        <div class="clear"></div>

          <div class="formRow clearfix">
                    <label></label>
                    <div class="formSubmit"><asp:Button ID="SubmitButton" runat="server" Text="Submit"  CssClass="btnSubmit" 
            onclick="SubmitButton_Click" /></div>
               </div>

       


    </ContentTemplate>
    </asp:UpdatePanel>

</div>
</asp:Content>

