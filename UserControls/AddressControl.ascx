<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddressControl.ascx.cs" Inherits="UserControls_AddressControl" %>
<%@ Register Assembly="InvertedSoftware.ShoppingCart.BusinessLayer" Namespace="InvertedSoftware.ShoppingCart.BusinessLayer.Controls"
    TagPrefix="cc1" %>

    <div class="formRow clearfix">
        <label>Address:</label>
        <div class="formInput"><asp:TextBox ID="AddressTextBox" runat="server"></asp:TextBox></div>
        <div class="formError"><asp:RequiredFieldValidator ID="AddressRequiredFieldValidator" 
    ControlToValidate="AddressTextBox" runat="server" 
    ErrorMessage="Address is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator></div>
    </div>

    <div class="formRow clearfix">
        <label>City:</label>
        <div class="formInput"><asp:TextBox ID="CityTextBox" runat="server"></asp:TextBox></div>
        <div class="formError"><asp:RequiredFieldValidator ID="CityRequiredFieldValidator" 
    ControlToValidate="CityTextBox" runat="server" ErrorMessage="City is Required" 
    SetFocusOnError="True">*</asp:RequiredFieldValidator></div>
    </div>

    <div class="formRow clearfix">
        <label>Country:</label>
        <div class="formInput"><cc1:LookupDataDropDownList ID="CountryLookupDataDropDownList"
    AutoPostBack="true" runat="server" 
    onselectedindexchanged="CountryLookupDataDropDownList_SelectedIndexChanged" LookupType="GetCountries"></cc1:LookupDataDropDownList></div>
        <div class="formError"><asp:RequiredFieldValidator ID="CountryRequiredFieldValidator" 
    ControlToValidate="CountryLookupDataDropDownList" runat="server" 
    ErrorMessage="Country is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator></div>
    </div>

    <div class="formRow clearfix" id="StateProvinceTr" visible="false" runat="server">
        <label>State/Province:</label>
        <div class="formInput">
            <cc1:LookupDataDropDownList ID="StateProvinceLookupDataDropDownList" 
                LookupType="NoBinding" AutoPostBack="true" runat="server" 
                onselectedindexchanged="StateProvinceLookupDataDropDownList_SelectedIndexChanged"></cc1:LookupDataDropDownList></div>
        <div class="formError"><asp:RequiredFieldValidator ID="StateRequiredFieldValidator" 
    ControlToValidate="StateProvinceLookupDataDropDownList" runat="server" 
    ErrorMessage="State/Province is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator></div>
    </div>

    <div class="formRow clearfix">
        <label>Zipcode:</label>
        <div class="formInput"><asp:TextBox ID="ZipcodeTextBox" runat="server"></asp:TextBox></div>
        <div class="formError"><asp:RequiredFieldValidator ID="ZipcodeRequiredFieldValidator" 
    ControlToValidate="ZipcodeTextBox" runat="server" 
    ErrorMessage="Zipcode is Required" SetFocusOnError="True">*</asp:RequiredFieldValidator></div>
    </div>


