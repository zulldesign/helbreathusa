<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SearchGiftRegistries.aspx.cs" Inherits="SearchGiftRegistries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="pageTitle">Search for a Gift Registry</div>

<div class="loginWrap">

    

     <div class="formRow clearfix">
        <label>Enter Email:</label>
        <div class="formInput"><asp:TextBox ID="EmailTextBox" AutoPostBack="true" OnTextChanged="EmailTextBox_TextChanged" runat="server"></asp:TextBox></div>
        <div class="formError"> <asp:RequiredFieldValidator ID="EmailTextBoxRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="EmailTextBox"></asp:RequiredFieldValidator></div>
        <div class="clear"></div>
        <div class="formError2"><asp:RegularExpressionValidator ID="EmailTextBoxRegularExpressionValidator" 
            runat="server" ErrorMessage="Invalid Email" ControlToValidate="EmailTextBox" 
            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></div>
    </div>
              
    <div class="loginElements clearfix">

        <div><asp:Button ID="SearchButton" runat="server" Text="Seach" 
            onclick="SearchButton_Click" CssClass="btnSubmit" /></div>
    </div>

</div> 
<br /><br />


        <asp:Literal ID="PrivateListLiteral" Visible="false" runat="server">This is a private Registry. Please <a href="Login.aspx">Login</a> or <a href="Register.aspx">Register</a> to view.</asp:Literal>
        <asp:ListView ID="GiftRegistryListView" ItemType="InvertedSoftware.ShoppingCart.DataObjects.GiftRegistryProduct" SelectMethod="GiftRegistryListView_GetData" DataKeyNames="GiftRegistryProductID" runat="server">
            <EmptyDataTemplate>
               
                   <div class="pageTitle">Search Results</div>
                       
                   <div class="notFound">Gift Registry Empty.</div>
                    
                
            </EmptyDataTemplate>



            <ItemTemplate>


              <div class="productWrap giftReg clearfix">
                <a class="productImage" title="<%# Item.ProductName %>" href="<%: ResolveClientUrl("~/Product/") %><%# HttpUtility.UrlEncode(Item.ProductName) %>"><img src='ProductImages/<%# Item.Thumbnail %>' alt='<%# Item.ProductName %>' border="0" width="75" height="75" /></a>
                <div class="productInfo">
                    <asp:Label ID="ProductNameLabel" runat="server" CssClass="title" Text='<%# Item.ProductName %>'></asp:Label>
                    <a href="<%: ResolveClientUrl("~/Product/") %><%# HttpUtility.UrlEncode(Item.ProductName) %>?GiftRegistryID=<%: GiftRegistry.GiftRegistryID %>&GiftRegistryProductID=<%# Item.GiftRegistryProductID %>">Buy as Gift</a>
                   
                </div>
             </div>

            </ItemTemplate>

             <LayoutTemplate>
              
                            <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                                <tr id="Tr2" runat="server" style="">
                                    <th id="Th1" runat="server"></th>
                                </tr>
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        
            </LayoutTemplate>
           
        </asp:ListView>
</asp:Content>

