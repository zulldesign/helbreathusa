<%@ Page Language="C#" MasterPageFile="Admin.master" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server" />

   

   <script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">
		google.load("visualization", "1", { packages: ["corechart"] });
		google.setOnLoadCallback(drawChart);
		function drawChart() {
			var toSalesdata = google.visualization.arrayToDataTable([
				['Product', 'Month', 'Sales'],
				<%= BindProductSalesChart(Convert.ToInt32(YearsDropDownList.SelectedValue)) %>
			]);

			var topSalesoptions = {
				title: 'Top Selling products',
				hAxis: { title: 'Month' },
				vAxis: { title: 'Sales' },
				bubble: { textStyle: { fontSize: 11 } }
			};

			var chart = new google.visualization.BubbleChart(document.getElementById('topSalesChart_div'));
			chart.draw(toSalesdata, topSalesoptions);

			var salesData = google.visualization.arrayToDataTable([
				['Month', 'Sales'],
				<%= BindSalesChart(Convert.ToInt32(YearsDropDownList.SelectedValue)) %>
			]);

			var salesOptions = {
				title: 'Yearly Sales'
			};

			var chart = new google.visualization.PieChart(document.getElementById('salesChart_div'));
			chart.draw(salesData, salesOptions);

		}
	</script>
<div id="parent" style="width:90%;">
	<div id="dropdown" style="width:100%; padding:20px; float:left; margin-left:100px"><b>Sales for:</b> <asp:DropDownList ID="YearsDropDownList" runat="server" AutoPostBack="True"></asp:DropDownList><br /></div>
    <table  border="0" width="100%" align="center">
        <tr>
            <td style="width:50%"><div id="salesChart_div" style="width:100%; height: 500px; float:left; z-index:-1; margin-left:100px" ></div></td>
            <td style="width:50%"><div id="topSalesChart_div" style="width:100%;height: 500px; float:left; z-index:-1"></div></td>
        </tr>
    </table>
	
	
	<div id="lastsales" style="width: 1200px; float:left; margin-left:100px; margin-top: 20px">
		<asp:Repeater ID="LastSalesRepeater" SelectMethod="LastSalesRepeater_GetData" runat="server">
					<HeaderTemplate>
					<table  border="0" style="width:100%" align="center">
					<tr> 
						<td colspan="3" class="tblHeader"><h2>Last Ten orders</h2></td>
                   </tr>
                       <tr>
                        <td style="width:33%"><b>Order Number</b></td>
						 <td style="width:33%"><b>Date Placed</b></td>
						<td style="width:33%"><b>Status</b></td>
					</tr>
					</HeaderTemplate>
					<ItemTemplate>
					<tr>
						 <td width="33%"><a href='Orders/Details.aspx?OrderID=<%# Eval("OrderID") %>'><%# Eval("OrderNumber")%></a></td>
						 <td width="33%"><%# Eval("OrderDate", "{0:MMMM d, yyyy}")%></td>
						<td width="33%"><%# Eval("OrderStatusName")%></td>
					</tr>
					</ItemTemplate>
					<FooterTemplate>
						</table>
					</FooterTemplate>
				</asp:Repeater>
		</div>
	</div>
</asp:Content>


