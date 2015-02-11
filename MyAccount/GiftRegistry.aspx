<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="GiftRegistry.aspx.cs" Inherits="MyAccount_GiftRegistry" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.Common" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="pageTitle">My Account: My Gift Registry</div>

<div class="accountNav">
    <a href="Orders.aspx" class="topEdge">My Orders</a>
    <a href="GiftRegistry.aspx">My Gift Registry</a>
    <a href="AccountInfo.aspx">Update Account Info</a>
    <a href="UpdatePassword.aspx" class="bottomEdge">Update Account Password</a>
</div>
<div class="accountWrap">
 


        
            To add items Please go to product page and click the "Add to my Gift Registry" button.
            <br /><br />

                <asp:ListView ID="GiftRegistryListView" ItemType="InvertedSoftware.ShoppingCart.DataObjects.GiftRegistryProduct" SelectMethod="GiftRegistryListView_GetData" DataKeyNames="GiftRegistryProductID" runat="server"  
                    onitemcommand="GiftRegistryListView_ItemCommand">
                    <EmptyDataTemplate>
                       
                         <div class="empty">Gift Registry Empty.</div>
                       
                    </EmptyDataTemplate>
                    <ItemTemplate>
                            

                        <div class="giftRow clearfix">
                            <div class="itemName"><a href='<%: ResolveClientUrl("~/Product/") %><%# HttpUtility.UrlEncode(Item.ProductName) %>'><%# Item.ProductName %></a></div>

                            <div class="removeGift" id="ButtonsColumn" runat="server">
                            <asp:Button CssClass="btnRemove" ID="DeleteButton" runat="server" CommandName="Remove" CommandArgument='<%# Item.GiftRegistryProductID %>' Text="Remove" OnClientClick="return confirm('Are you sure you want to remove this item?');" />
                            </div>
                        </div>  
                            
                            
                    </ItemTemplate>
                    <LayoutTemplate>

                        <table id="Table1" runat="server">
                            <tr id="Tr1" runat="server">
                                <td id="Td1" runat="server">
                                    <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                                        <tr id="Tr2" runat="server" style="">
                                            <th id="Th1" runat="server"></th>
                                            <th id="Th2" runat="server">
                                            </th>
                                        </tr>
                                        <tr ID="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td id="Td2" runat="server" style="">
                                </td>
                            </tr>
                        </table>
                        <br /><br />
                    </LayoutTemplate>
                </asp:ListView>
           
            <b>Gift Registry Public Link:</b> <a href='<%= StoreConfiguration.GetConfigurationValue(ConfigurationKey.StoreURL) %>/SearchGiftRegistries.aspx?Registry=<%: GetLoggedCustomer().Email %>'><%= ConfigurationManager.AppSettings["StoreURL"]%>/SearchGiftRegistries.aspx?Registry=<%: GetLoggedCustomer().Email %></a>
            <br /><br />
            <div class="clearfix">
                <div class="left" style="height:27px;line-height:27px;"><b>Gift Registry visibility:</b> </div>
            

                <div class="left"><asp:RadioButtonList ID="VisibilityRadioButtonList" runat="server" 
                        AutoPostBack="True" RepeatDirection="Horizontal" 
                        onselectedindexchanged="VisibilityRadioButtonList_SelectedIndexChanged">
                        <asp:ListItem Value="true">Public</asp:ListItem>
                        <asp:ListItem Value="false">Logged In Users</asp:ListItem>
                </asp:RadioButtonList></div>
            </div>
         

</div>
<div class="clear"></div>
</asp:Content>

