<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductsGridControl.ascx.cs" Inherits="UserControls_ProductsGridControl" %>
<%@ OutputCache Duration="100" VaryByParam="None" VaryByCustom="CategoryPage" %>
    <div class="totalRecords">Total of: <b><%: TotalRecords%> Products</b></div>

    <div class="product clearfix">
    <asp:Literal ID="MessageLiteral" runat="server"></asp:Literal>
    <% if (!IsInfiniteScroll) {  %>
        <asp:Repeater ID="ProductsRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.CategoryProduct" runat="server" 
            onitemdatabound="ProductsRepeater_ItemDataBound">
    <HeaderTemplate>
        
    </HeaderTemplate>
    <ItemTemplate>
    
        <asp:HiddenField ID='ProductIDHiddenField' Value='<%# Item.ProductID %>' runat='server' />
        <asp:HiddenField ID='IsInStockHiddenField' Value='<%# Item.IsInStock %>' runat='server' />
        <asp:HiddenField ID='InventoryActionIDHiddenField' Value='<%# Item.InventoryActionID %>' runat='server' />
            
            <div class="productWrap clearfix">
                <a class="productImage" title="<%# Item.ProductName %>" href="<%: ResolveClientUrl("~/Product/") %><%# HttpUtility.UrlEncode(Item.ProductName) %>"><img src='<%: ResolveClientUrl("~/ProductImages/") %><%# Item.Thumbnail %>' alt='<%# Item.ProductName %>' border="0" width="75" height="75" /></a>
                <div class="productInfo">
                    <asp:Label ID="ProductNameLabel" runat="server" CssClass="title" Text='<%# Item.ProductName.Length > 25 ? Item.ProductName.Substring(0, 25) : Item.ProductName %>'></asp:Label>
                    <%# Item.Description %> <a href="<%: ResolveClientUrl("~/Product/") %><%# HttpUtility.UrlEncode(Item.ProductName) %>">More...</a>
                    <br /><br />
                    <asp:Button ID="AddButton" runat="server" CssClass="addCart" OnClientClick='<%# String.Format("return softAddToCart({0}, {1}{2}{3});",Item.ProductID, (char)39, Item.ProductName, (char)39) %>' />
                </div>
           </div>
        
    </ItemTemplate>
    <FooterTemplate>
  
    </FooterTemplate>
</asp:Repeater>
        </div>
        <%: Scripts.Render("~/bundles/Pager") %>
<div id="PagerDiv"></div>
<% } else {  %>
        <script src="../Scripts/knockout-3.1.0.js"></script>

        <div data-bind="foreach: items">
            <div class="productWrap clearfix">
                <a class="productImage"  data-bind="attr: { href: getHref(ProductName), title: ProductName }"><img data-bind="    attr: { src: getThumbnail(Thumbnail), alt: ProductName }" border="0" width="75" height="75" /></a>
                <div class="productInfo">
                    <span data-bind="text: ProductName.substring(0, 25)" class="title"></span>
                    <div data-bind="text: Description"></div><a data-bind="attr: { href: getHref(ProductName) }">More...</a>
                    <br /><br />
                    <button data-bind="enable: IsEnabled, click: $parent.addToCart" class="addCart"><%# InvertedSoftware.ShoppingCart.Localization.FormsResources.Buy %></button>
                </div>
           </div>
         </div>
        </div>
       <script type="text/javascript">

           var viewModel = {
               items: ko.observableArray([]),
               pageNumber: 0,
               pendingRequest: ko.observable(false),
               addToCart: function (Product) {
                   softAddToCart(Product.ProductID, Product.Name);
               }
           };

           $(window).scroll(function () {
               if ($(window).scrollTop() > $(document).height() - $(window).height() - 200) {
                   getItems(10)
               }
           });

           function getItems(pageSize) {
               if (!viewModel.pendingRequest()) {
                   viewModel.pendingRequest(true);

                   $.ajax({
                       type: 'GET',
                       url: '../data/CategoryProducts.ashx',
                       data: {
                           Page: viewModel.pageNumber++,
                           PerPage: pageSize,
                           CategoryName: '<%: HttpUtility.UrlEncode((string)Page.RouteData.Values["CategoryName"]) %>',
                           Sort: '<%: Request["Sort"] %>'
                       },
                       success: function (entries) {
                           ko.utils.arrayForEach(entries, function (entry) {
                               viewModel.items.push(entry);
                           });
                           viewModel.pendingRequest(false);
                       },
                       error: function () {
                           viewModel.pendingRequest(false);
                       },
                       dataType: 'json'
                   });
               }
           }

           function getHref(product) {
               return '../Product/' + encodeURIComponent(product);
           }

           function getThumbnail(Thumbnail) {
               return '../ProductImages/' + Thumbnail;
           }

           function getTitle(product) {
             
               return product.sub
           }

           ko.applyBindings(viewModel);
           getItems(100);
           viewModel.pageNumber = 10;
            </script>
<% } %>
<script src="../Scripts/jquery.scrollUp.min.js"></script>
 <%: Scripts.Render("~/bundles/SoftAddToCart") %>
<script type="text/javascript">
    $(function () {
        $.scrollUp();
    });
</script>




