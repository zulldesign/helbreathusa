<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="MyAccount_Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
 <ContentTemplate>

<div class="pageTitle">My Account: My Orders</div>

                Please press "Details" for more information about the purchased item.<br />

                <asp:GridView ID="OrderProductsGridView" CellPadding="2" CssClass="gridview gridviewDetails" runat="server" 
                    AutoGenerateColumns="False" ItemType="InvertedSoftware.ShoppingCart.DataObjects.OrderItem" SelectMethod="OrderProductsGridView_GetData">

                    
                    <Columns>
                        <asp:TemplateField HeaderText="Product" SortExpression="ProductName">
                            <ItemTemplate>
                                <%# Item.ProductName %>
                                <%# GetDownloadText(Item. DownloadURL, Item.DownloadKey)%>
                                <asp:Repeater ID="OptionsRepeater" ItemType="InvertedSoftware.ShoppingCart.DataObjects.OrderProductOption" DataSource='<%# Item.OptionList %>' runat="server">
                                <ItemTemplate><br /><%# Item.ProductOptionName %></ItemTemplate>
                                </asp:Repeater>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CatalogNumber" HeaderText="Catalog No." 
                            SortExpression="CatalogNumber" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                            SortExpression="Quantity" />
                        <asp:BoundField DataField="PricePerUnit" DataFormatString="{0:C}" 
                            HeaderText="Price Per Unit" SortExpression="PricePerUnit" />
                        <asp:BoundField DataField="TotalPrice" DataFormatString="{0:C}"
                            HeaderText="Price" SortExpression="TotalPrice" />
                    </Columns>
                </asp:GridView>

    <asp:GridView ID="OrdersGridView" DataKeyNames="OrderID" ItemType="InvertedSoftware.ShoppingCart.DataObjects.OrderDisplay" SelectMethod="OrdersGridView_GetData" runat="server" AllowPaging="True" PageSize="5"
                AutoGenerateColumns="False" CssClass="gridview" AlternatingRowStyle-CssClass="gridRowAlt" SelectedRowStyle-CssClass="gridRowSelected">
                
                <Columns>
                    <asp:CommandField ShowSelectButton="True" selecttext="Details"  />
                    <asp:BoundField DataField="OrderStatusName" HeaderText="Status" 
                        SortExpression="OrderStatusName" />
                    
                       <asp:TemplateField HeaderText="Order/Routing Number">
                        <ItemTemplate>
                            Order: <%# Item.OrderNumber %>
                            <br />
                            Routing: <%# Item.ShippingNumber %>
                          
                        </ItemTemplate>
                    </asp:TemplateField>

                  
                   
                    <asp:TemplateField HeaderText="Address">
                        <ItemTemplate>
                            <div class="ordersAddress">
                            <%# Item.Address %>,<%# Item.City %>, <%# Item.StateName %> <%# Item.ProvinceName %>,<br />
                            <%# Item.CountryName %>, <%# Item.Zipcode %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="DatePlaced" HeaderText="Placed" 
                        SortExpression="DatePlaced" DataFormatString="{0:MM/dd/yyyy}" />
                   
                   <asp:TemplateField HeaderText="Shipping">
                        <ItemTemplate>
                            Via: <%# Item.ShippingProviderName %>
                            <br />
                            <%# Item.DateShipped %>
                          
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:BoundField DataField="Total" DataFormatString="{0:C}" 
                        HeaderText="Total" SortExpression="Total" />
                    <asp:BoundField DataField="Shipping" DataFormatString="{0:C}" 
                        HeaderText="Shipping" SortExpression="Shipping" />
                    <asp:BoundField DataField="Tax" DataFormatString="{0:C}" HeaderText="Tax" SortExpression="Tax" />
                </Columns>
            </asp:GridView>

         

      <br /><br />    
      < <a href="Default.aspx">back to account page</a><br /><br />  




   </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

