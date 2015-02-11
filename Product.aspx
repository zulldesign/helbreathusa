<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Product.aspx.cs" Inherits="Product" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.Common" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.BusinessLayer" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.Localization" %>

<%@ Register src="UserControls/RelatedProductsControl.ascx" tagname="RelatedProductsControl" tagprefix="uc1" %>

<%@ Register src="UserControls/ProductOptionsControl.ascx" tagname="ProductOptionsControl" tagprefix="uc2" %>

<%@ Register src="UserControls/CustomFieldsControl.ascx" tagname="CustomFieldsControl" tagprefix="uc3" %>

<%@ Register src="UserControls/TagsControl.ascx" tagname="TagsControl" tagprefix="uc4" %>

<%@ Register src="UserControls/ProductBreadcrumbControl.ascx" tagname="ProductBreadcrumbControl" tagprefix="uc5" %>
<%@ Register src="UserControls/ProductReviewsControl.ascx" tagname="ProductReviewsControl" tagprefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
	

<% if(this.ProductImages.Count > 0){ %>
	<script src="../Scripts/jquery.jcarousel.min.js"></script>
    <%: Scripts.Render("~/bundles/ProductCarousel") %>
    <%: Styles.Render("~/Content/jcarousel") %>

    <div class="productImages">  
            <div class="connected-carousels">
                <div class="stage">
                    <div class="carousel carousel-stage">
                        <ul>
                            <%  for (int i = 0; i < this.ProductImages.Count(); i++)
							    {%>
						            <li><img id="Img2" src="<%: ResolveClientUrl("~/ProductImages/") %><%: this.ProductImages[i].Replace("_t", "")%>" width="400" alt="<%: CartProduct.ProductName%>"></li>
						    <%} %>
                        </ul>
                    </div>
                    <a href="#" class="prev prev-stage"><span>&lsaquo;</span></a>
                    <a href="#" class="next next-stage"><span>&rsaquo;</span></a>
                </div>

                <div class="navigation">
                    <a href="#" class="prev prev-navigation">&lsaquo;</a>
                    <a href="#" class="next next-navigation">&rsaquo;</a>
                    <div class="carousel carousel-navigation">
                        <ul>
                            <%  for (int i = 0; i < this.ProductImages.Count(); i++)
							    {%>
						            <li><img id="Img1" src="<%: ResolveClientUrl("~/ProductImages/") %><%: this.ProductImages[i]%>" width="75" height="75" alt="<%: CartProduct.ProductName%>"></li>
						    <%} %>
                        </ul>
                    </div>
                </div>
            </div>
	
	<% } else { %>

		<div class="productNoImages">

	<%} %>
	

	<div class="onProductPage pageTitle featuredTitle">Previously Viewed</div>

	<div class="onProductPage featured clearfix">
		<div class="featuredWrap clearfix">


		Previously Viewed (<a href="#" id="viewHistorySettings" onclick="javascript:changeViewHistory();"></a>)

		<div id="viewHistory" class="clearfix"></div>
		</div>
	</div>

   

	<uc5:ProductBreadcrumbControl ID="ProductBreadcrumbControl1" runat="server" />


</div>

<% if(this.ProductImages.Count > 0){ %>

		<div class="productInformation">

	<% } else { %>

		<div class="infoNoImages">

	<%} %>

			<div itemscope itemtype="http://schema.org/Product">
	<div class="productTitle">
		  <span itemprop="name"><%: CartProduct.ProductName%></span>
		<% if (CartProduct.SalePrice > 0)
	   {  %>
	   - <b>On Sale!!</b>
	</div>
			 
	Catalog number: <%: CartProduct.CatalogNumber%>
				 <br /><br />
				 

	 <% } else { %>
		   </div>
	 <%} %>
	

	<span itemprop="description"><%= CartProduct.Description%></span>

<%if (CartProduct.Height > 0 && CartProduct.Length > 0 && CartProduct.Width > 0)
  {%>
	
	<br /><br />Dimensions: <%: CartProduct.Height %>"x<%: CartProduct.Length%>"x<%: CartProduct.Width%>"
  
<%} %>
<%if (CartProduct.Weight > 0)
  {%>
  
	<br />Weight: <%: CartProduct.Weight%>LBS
  
<%} %>

	<uc2:ProductOptionsControl ID="ProductOptionsControl1" runat="server" />

		<uc3:CustomFieldsControl ID="CustomFieldsControl1" runat="server" />
<br /><br />
	
	<div class="priceWrap">
		<% if (CartProduct.SalePrice > 0)
		   {  %>
		   Price: <strike><%: CartProduct.Price.ToString("c")%></strike> 

		   <% if (CartProduct.IsSubscription)
			  {  %>
			  Per Month
				<% if (CartProduct.SubscriptionSetupFee > 0) {  %>
	
		<%} %>
		<%} %>
		   <br />
		   <span class="sale">Sale Price: <%: CartProduct.SalePrice.ToString("c")%>
		   <% if (CartProduct.IsSubscription)
			  {  %>
			  Per Month</span>
				<% if (CartProduct.SubscriptionSetupFee > 0) {  %>
			
			  <br /><br />
			  <span class="setupFee">One time setup fee: <%: CartProduct.SubscriptionSetupFee.ToString("c") %></span>
			  <% } else { %>

				<%} %>
			  <%} %><br />
		<% } else { %>
			<div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
			Price: <b><span itemprop="price"><%: CartProduct.Price.ToString("c")%></span></b>
				<link itemprop="availability" href="http://schema.org/InStock" />In stock
			</div>
			 <% if (CartProduct.IsSubscription)
			  {  %>
			  Per Month
				<% if (CartProduct.SubscriptionSetupFee > 0) {  %>
			
			  <br />
			  Per Month Setup Fee: <%: CartProduct.SubscriptionSetupFee.ToString("c") %>
				<%} %>
			  <%} %>
		<%} %>
	</div>
			</div>
	<asp:Button ID="AddButton" ClientIDMode="Static" runat="server" CssClass="addCart" onclick="AddButton_Click" OnClientClick="return checkInventory();" />
	<asp:TextBox ID="QtyTextBox" CssClass="quanity" ClientIDMode="Static" Text="1" MaxLength="4" Columns="3" runat="server"></asp:TextBox>
	<asp:RequiredFieldValidator ControlToValidate="QtyTextBox" ID="QtyRequiredFieldValidator" ForeColor="red" runat="server"><%: FormsResources.Qty %></asp:RequiredFieldValidator>
	<asp:RangeValidator
		ID="QtyRangeValidator" ControlToValidate="QtyTextBox" runat="server" ForeColor="red" Style="display:block;" MinimumValue="1" MaximumValue="9999" Type="Integer"><%: FormsResources.QtyRange %></asp:RangeValidator>
		<asp:LoginView id="LoginView1" runat="server">
					<AnonymousTemplate>
						<a href="~/Login.aspx" runat="server">Login To add to Gift Registry</a>
					</AnonymousTemplate>
					<RoleGroups>
						<asp:RoleGroup Roles="Customer">
							<ContentTemplate>
								<asp:Button ID="GiftButton" runat="server" CausesValidation="false" Text="Add to my Gift Registry" 
									onclick="GiftButton_Click" />
							</ContentTemplate>
						</asp:RoleGroup>
					</RoleGroups>
				</asp:LoginView>
	<asp:Literal ID="MessageLiteral" runat="server"></asp:Literal>
 <%if (CartProduct.IsReviewEnabled)
 { %>
			 <%if (CartProduct.RatingScore > 0 && CartProduct.TotalReviewCount > 0)
				{ %>
					<div itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
						<span itemprop="ratingValue"><%: CartProduct.RatingScore %></span>/5 stars - based on <span itemprop="reviewCount"><%: CartProduct.TotalReviewCount %></span> reviews
					</div>
			<%} %>

			<uc6:ProductReviewsControl ID="ProductReviewsControl1" runat="server" />
			<%: Scripts.Render("~/bundles/ProductReviews") %>
			<script type="text/javascript">
				$(function() {
					RenderProductReviews(<%: CartProduct.ProductID %>);
				});
			</script>
			<div id="productReviews" style="border:solid 1px; padding : 4px; width:100%; height : 300px; overflow : auto;"></div>
			<br />
			<div id="loadMoreReviews" style="cursor:pointer" onclick="RenderProductReviews(<%: CartProduct.ProductID %>);">See More Reviews</div> 

 <%} %>
</div>
<div class="clear"></div>
<div class="tagWrap">
	<uc1:RelatedProductsControl ID="RelatedProductsControl1" runat="server" />

	<uc4:TagsControl ID="TagsControl1" runat="server" />
</div>
	<%: Scripts.Render("~/bundles/ProductPageServices") %>


	<script type="text/javascript">
		function checkInventory() {
			if(inventoryChecked)
				return inventoryChecked;
			var qty = document.getElementById("<%= QtyTextBox.ClientID %>").value;
		var objRegExp  = /(^-?\d\d*$)/;
		if(objRegExp.test(qty))
			GetProductStockStatus(<%: CartProduct.ProductID %>, parseInt(qty));
		return inventoryChecked;
	}

	function resetInventoryChecked(){
		inventoryChecked = false;
	}

	var viewHistory = <%: ExperienceManager.GetHistoryCookie(HttpContext.Current).Values[Utils.HISTORY_COOKIE_ENABLED].ToLower() %>;

	function changeViewHistory(){
   
		if(viewHistory){
			// Turn off history
			$('#viewHistorySettings').html("Turn On")
			$('#viewHistory').hide('slow');
			ChangeHistorySettings(false);
			// Signal the service
		}else{
			// Turn on history
			$('#viewHistorySettings').html("Turn Off")
			$('#viewHistory').show('slow');
			ChangeHistorySettings(true);
		}
		viewHistory = !viewHistory;
	}

	$(document).ready(function() {
		AddProductToViewHistory(<%: CartProduct.ProductID %>);
			if(viewHistory){
				GetProductHistory();
				$('#viewHistorySettings').html("Turn Off");
			}else{
				$('#viewHistorySettings').html("Turn On");
			}
		});
</script>
			
</asp:Content>

