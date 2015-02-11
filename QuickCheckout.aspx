<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuickCheckout.aspx.cs" Inherits="QuickCheckout" %>

<%@ Register src="UserControls/RelatedProductsControl.ascx" tagname="RelatedProductsControl" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Express Checkout</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-color:white">
        <div class="mainWrapper">
            <div class="pageTitle featuredTitle">The item has been added to your cart.</div>
            <div class="pageTitle featuredTitle" style="align-content:center"><input type="button" style="font-size:large" value="Express Checkout" onclick="javascript: redirectToCheckout();" /> OR <input type="button" style="font-size:large" value="Continue to Cart" onclick="javascript: redirectToCart();" /></div>
            <div class="clear"></div>
            <div class="tagWrap">
                <uc1:RelatedProductsControl ID="RelatedProductsControl1" LimitTotal="2" runat="server" />
            </div>
         </div>
            </div>
    </form>
    <script type="text/javascript">
        function redirectToCheckout() {
            window.top.location.href = "<%: ResolveClientUrl("~/Checkout.aspx") %>";
        }

        function redirectToCart() {
            window.top.location.href = "<%: ResolveClientUrl("~/ShoppingCart.aspx") %>";
         }
    </script>
</body>
</html>
