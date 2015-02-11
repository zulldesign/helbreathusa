<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductReviewsControl.ascx.cs" EnableViewState="true" Inherits="UserControls_ProductReviewsControl" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.DataLayer.Database" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.DataLayer.Cache" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.BusinessLayer.Controls" %>
	<div class="pageTitle">Product Reviews</div>

		<asp:LoginView ID="ReviewLoginView" runat="server">
			<AnonymousTemplate>
			<a href="#" onclick="javascript:showReviewMethod();">How can I review products?</a> 
			<br /><br />
			</AnonymousTemplate>
			<RoleGroups>
				<asp:RoleGroup Roles="Customer">
					<ContentTemplate>
						  <asp:Panel ID="AddReviewPanel" runat="server">
							
							<b>Add a Review:</b> please fill out the form below.
					 
							<div class="success"><asp:Literal ID="MessageLiteral" runat="server"></asp:Literal></div>
							
							<asp:Repeater ID="ReviewCategoriesRepeater" DataSource="<%# CacheManager.GetCachedLookupTable(LookupDataEnum.GetProductReviewCategories, false) %>" runat="server">
							<HeaderTemplate>
								<link rel="stylesheet" type="text/css" href="<%: Styles.Url("~/Content/jRating") %>" media="screen" />
								<%: Scripts.Render("~/bundles/jRating") %>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:HiddenField ID="ProductReviewCategoryIDHiddenField" Value='<%# Eval("Key") %>' runat="server" />
								<asp:HiddenField ID="SelectedRatingHiddenField" Value="" runat="server" />
							
								 <div class="reviewAtt"><%# Eval("Value")%>:
								 <b><span id="addStars-cap<%#(((RepeaterItem)Container).ItemIndex) %>"></span></b>
								 </div>
									
									<div id="addStars-wrapper<%#(((RepeaterItem)Container).ItemIndex) %>" class="clearfix">
										<div class="basic<%#(((RepeaterItem)Container).ItemIndex) %>" data-average="1" data-id="1"></div>

										 <script type="text/javascript">
											 $(document).ready(function () {
												 $(".basic<%#(((RepeaterItem)Container).ItemIndex) %>").jRating({
													 step: true,
													 length: 5,
													 rateMax: 5,
													 bigStarsPath: '<%: ResolveClientUrl("~/Scripts/jRating-master/icons/stars.png") %>',
													 smallStarsPath: '<%: ResolveClientUrl("~/Scripts/jRating-master/icons/small.png") %>',
													 onSuccess: function (value) {
														 $('#<%#(((RepeaterItem)Container).FindControl("SelectedRatingHiddenField").ClientID) %>').val(value);
													 }
												 });
											 });
											</script>
									</div>
							</ItemTemplate>
							<FooterTemplate>
								
							</FooterTemplate>
							</asp:Repeater>
							
							<div class="formreview"><asp:TextBox ID="ReviewTextBox" runat="server" TextMode="MultiLine" ValidationGroup="AddReview" Columns="50" Rows="6"></asp:TextBox></div>
							<asp:RequiredFieldValidator ID="ReviewTextBoxRequiredFieldValidator" Display="Dynamic" ValidationGroup="AddReview" ControlToValidate="ReviewTextBox" runat="server" ErrorMessage="Review text is missing."></asp:RequiredFieldValidator>
							<div class="error"><asp:RegularExpressionValidator ID="ReviewTextBoxRegularExpressionValidator" Display="Dynamic" ValidationGroup="AddReview" ControlToValidate="ReviewTextBox" Text="Please keep reviews under 500 characters" ValidationExpression="(\s|.){0,500}$" runat="server" /></div>
							<asp:Button ID="ReviewButton" runat="server" Text="Review" CssClass="btnSubmit" 
									onclick="ReviewButton_Click" ValidationGroup="AddReview" />
							<div class="dottedLine"></div>
						
						</asp:Panel>
					</ContentTemplate>
				</asp:RoleGroup>
			</RoleGroups>
		</asp:LoginView>