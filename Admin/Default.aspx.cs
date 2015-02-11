using InvertedSoftware.ShoppingCart.DataLayer.Models;
using System;
using System.Linq;
using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;
using System.Web.UI.WebControls;
using System.Text;
using InvertedSoftware.ShoppingCart.Common;
using System.Web;

public partial class _Default : System.Web.UI.Page {

    ShoppingCartNET25Entities context = new ShoppingCartNET25Entities();

    protected void Page_Load(object sender, EventArgs e) {
       
        if (!Page.IsPostBack)
        {
            BindYearsDropDown();
            BindSalesChart(DateTime.Now.Year);
            BindProductSalesChart(DateTime.Now.Year);
        }
    }

    protected void Page_UnLoad(object sender, EventArgs e) {
       context.Dispose();
    }

    public void BindYearsDropDown()
    {
        for (int i = DateTime.Now.Year - 20; i < DateTime.Now.Year + 20; i++)
            YearsDropDownList.Items.Add(new ListItem(i.ToString(), i.ToString()));
        YearsDropDownList.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
    }

    public string BindSalesChart(int year)
    {

        StringBuilder sb = new StringBuilder();
            var sales = from o in context.Orders
                        where o.DatePlaced.Value.Year == year
                        group o by o.DatePlaced.Value.Month into g
                        orderby g.Key
                        select new { Month = g, Orders = g.Count() };

            foreach (var sale in sales)
                sb.Append("['" + Enum.Parse(typeof(Month), sale.Month.Key.ToString()).ToString() + "'," + sale.Orders + "]," + Environment.NewLine);
            return sb.ToString().TrimEnd(new char[] { ',', '\r', '\n' });
    }

    public string BindProductSalesChart(int year)
    {

        StringBuilder sb = new StringBuilder();

            var productSales = from o in context.Orders
                               where o.DatePlaced.Value.Year == year
                               group o by o.DatePlaced.Value.Month into g
                               orderby g.Key
                               select new
                               {
                                   Month = g,
                                   TopProducts = (from op in context.OrderProducts
                                                  where op.OrderDate.Value.Year == year && op.OrderDate.Value.Month == g.Key
                                                  group op by op.ProductID into opg
                                                  orderby opg.Count() descending
                                                  select new { ProductName = context.Products.Where(p => p.ProductID == opg.Key).FirstOrDefault().ProductName, ProductCount = opg.Count() }).Take(5)
                               };

            if (productSales.Count() == 0)
            {
                sb.Append("['No Sales Yet', " + 6 + ", " + 0 + "]," + Environment.NewLine);
            }
            else
            {
                foreach (var sale in productSales)
                {
                    int month = sale.Month.FirstOrDefault().DatePlaced.Value.Month;
                    foreach (var topProduct in sale.TopProducts)
                    {
                        sb.Append("['" + HttpUtility.JavaScriptStringEncode(topProduct.ProductName) + "', " + month + ", " + topProduct.ProductCount + "]," + Environment.NewLine);
                    }
                }
            }
            return sb.ToString().TrimEnd(new char[] { ',', '\r', '\n' });
    }

    public System.Collections.IEnumerable LastSalesRepeater_GetData()
    {
        return from o in context.Orders.Take(10)
               join os in context.OrderStatus
               on o.OrderStatusID equals os.OrderStatusID
               orderby o.OrderDate descending
               select new { o.OrderID, o.OrderNumber, o.OrderDate, os.OrderStatusName };

    }
}
