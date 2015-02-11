<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Async="true" CodeFile="ShoppingCart.aspx.cs" Inherits="ShoppingCart" %>

<%@ Register src="UserControls/GoogleCheckoutControl.ascx" tagname="GoogleCheckoutControl" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="pageTitle"><asp:Literal ID="MessageLiteral" runat="server"></asp:Literal></div>

<div class="cartMessages"><asp:Literal ID="CouponMessageLiteral" runat="server"></asp:Literal></div>

<table class="cartTbl">

 <asp:Repeater ID="CartRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.CartItem" runat="server" 
    onitemcommand="CartRepeater_ItemCommand">
    <HeaderTemplate>
        <tr class="headerTbl">
            <td class="productTbl">Product</td>
            <td>Catalog No.</td>
            <td>Quantity</td>
            <td>Remove</td>
            <td>Price</td>
            <td>Subtotal</td>
        </tr>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td class="productTbl">
                <b><%# Item.ProductName %> </b>
                <div><%# GetProductOptions(Container.ItemIndex) %></div>
                <div><%# GetCustomFields(Container.ItemIndex) %></div>
            </td>
            <td><%# Item.CatalogNumber %></td>
            <td><asp:TextBox ID='QuantityTextBox' Text='<%# Item.Quantity %>' Columns="3" runat="server" CssClass="quanity"></asp:TextBox></td>
            <td class="removeTbl"><asp:Button ID="RemoveButton" runat="server" Text="REMOVE ITEM" CssClass="btnRemove" /></td>
            <td><%# Item.PricePerUnit.ToString("c") %></td>
            <td><%# Item.Subtotal.ToString("c") %></td>
        </tr>
      
    </ItemTemplate>
    <FooterTemplate>
        <tr>
            <td colspan="6" align="right" class="whiteTbl">
                <asp:Repeater ID="OffersRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.Coupon" onitemcommand="OffersRepeater_ItemCommand" runat="server">
                <HeaderTemplate>
                    <table class="couponTbl" align="right">
                </HeaderTemplate>
                <ItemTemplate>
                <tr>
                    <td class="whiteTbl"><asp:Button ID="RemoveOfferButton" CommandName="DeleteCoupon" CommandArgument='<%# Item.CouponID %>' runat="server" Text="Remove" CssClass="btnRemoveCoupon" /></td>
                    <td class="coupon"><%# Item.CouponDescription %></td>
                </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
                </asp:Repeater>
            </td>
            <tr>
                <td colspan="5" class="whiteTbl"> 
                    <div class="right">
                    <b>Add Offer/Coupon Code:</b> 
                    <asp:RequiredFieldValidator ID="OfferCodeTextBoxRequiredFieldValidator" ControlToValidate="OfferCodeTextBox" ValidationGroup="Offers" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="OfferCodeTextBox" ValidationGroup="Offers" runat="server" CssClass="smallInput"></asp:TextBox><asp:Button ID="AddOfferButton" ValidationGroup="Offers" runat="server" Text="Add" CommandName="AddCoupon" CssClass="btnAdd" />
                    </div>
                </td>
                <td class="whiteTbl"></td>
            </tr>
        </tr>
        <tr>
            <td colspan="5" class="whiteTbl alignRight">Discounts</td>
            <td class="whiteTbl"><%= this.Cart.Discounts.ToString("c")%></td>
        </tr>
        <tr class="total">
            <td colspan="5" class="whiteTbl alignRight">SubTotal</td>
            <td class="whiteTbl"><%= this.Cart.Subtotal.ToString("c")%></td>
        </tr>
    </FooterTemplate>
</asp:Repeater>

</table>



   
<table class="cartButtons">
<tr>
    <td align="left"><asp:Button ID="ContinueButton" runat="server" Text="Continue Shopping" 
            onclick="ContinueButton_Click" CssClass="btnContinue" /></td>
    <td><asp:Button ID="UpdateButton" runat="server" Text="Update Quantity" 
            onclick="UpdateButton_Click" CssClass="btnUpdate" /></td>
    <td align="right"><asp:Button ID="CheckoutButton" runat="server" Text="Checkout" 
            onclick="CheckoutButton_Click" CssClass="btnCheckout" />
            <br />
            <br />
            <uc1:GoogleCheckoutControl ID="GoogleCheckoutControl1" runat="server" />
    </td>
</tr>
</table>


     
       <br /><br />

        <div class="pageTitle featuredTitle">Saving Options</div>
        <div class="featured clearfix">

            <div class="featuredWrap">

                <div class="clearfix saveArea">
                    <div class="savingText">Saving your cart will enable you to continue your purchase at a later date from the current computer or if you log into your account, from any computer.</div>
                    <div class="savingTextBtn"><asp:Button ID="SaveButton" ValidationGroup="Save" runat="server" Text="Save My Cart" onclick="SaveButton_Click" CssClass="btnSaveCart" /></div>
                </div>
                <div class="line"></div>
                <div class="clearfix saveArea">
                    <div class="savingText">Email your cart to yourself or friends. Please separate Multiple Recipients using ","
                    <asp:TextBox ID="EmailTextBox" MaxLength="200" ValidationGroup="Email" runat="server" CssClass="smallInput"></asp:TextBox><asp:RequiredFieldValidator
                    ID="EmailRequiredFieldValidator" ValidationGroup="Email" ControlToValidate="EmailTextBox" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator></div>
                    <div class="savingTextBtn"><asp:Button ID="EmailButton" runat="server" ValidationGroup="Email" Text="Email My Cart"  CssClass="btnEmailCart" 
                    onclick="EmailButton_Click" /></div>
                </div>
          
            </div>

      </div>
</asp:Content>

