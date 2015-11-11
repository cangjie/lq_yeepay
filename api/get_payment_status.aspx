<%@ Page Language="C#" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        
        try
        {
            int mallOrderId = (Request["mallorderid"] == null) ? 886 : int.Parse(Request["mallorderid"].Trim());
            Order order = new Order(mallOrderId);
            if (order._fields["order_paymethod"].ToString().Equals("yeepay"))
                order.SyncYeepayPaymentStatus();
            Response.Write("{\"status\":0,\"is_paid\":" + order.Status.ToString().Trim() + "}");
        }
        catch
        {
            Response.Write("{\"status\":1}");
        }
        
        
    }
</script>