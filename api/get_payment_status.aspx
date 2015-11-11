<%@ Page Language="C#" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        int mallOrderId = (Request["mallorderid"] == null) ? 809 : int.Parse(Request["mallorderid"].Trim());
        Order order = new Order(mallOrderId);
        try
        {
            order.SyncYeepayPaymentStatus();
            Response.Write("{\"status\":0,\"is_paid\":" + order.Status.ToString().Trim() + "}");
        }
        catch
        {
            Response.Write("{\"status\":1}");
        }
        
        
    }
</script>