<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string data = Request.QueryString["data"].ToString(); //回调中的参数data
        string encryptkey = Request.QueryString["encryptkey"].ToString();//回调中的参数encryptkey
        string callback_result = YJPayUtil.checkYbCallbackResult(data, encryptkey);
        
System.IO.File.AppendAllText(Server.MapPath("callback.log"), DateTime.Now.ToString() + " "
            + callback_result + "\r\n");

        JavaScriptSerializer serializer = new JavaScriptSerializer();
        Dictionary<string, object> json = (Dictionary<string, object>)serializer.DeserializeObject(callback_result);
        object orderId;
        json.TryGetValue("orderid", out orderId);

        Order order = new Order(orderId.ToString());
        order.Status = 2;

        string redirectUrl = "";

        //Response.Write(callback_result + "<br/>" + order._fields["order_body"].ToString().Trim());
        //Response.End();
        
        switch (order._fields["order_body"].ToString().Trim())
        {
            case "“放飞梦想我能行”知心姐姐北京精品营再次出发":
                redirectUrl = "http://www.luqinwenda.com/index.php?app=public&mod=Passport&act=paysuccess2&product_id=" + ((Request["product_id"] == null) ? "" : Request["product_id"].Trim());
                break;
            case "卢勤问答平台官方书城":
                redirectUrl = "http://mall.luqinwenda.com/paySuccess.aspx?product_id=" + ((Request["product_id"] == null) ? "" : Request["product_id"].Trim());
                break;
            case "卢勤问答平台官方夏令营":
                redirectUrl = "http://mall.luqinwenda.com/paySuccess.aspx?product_id=" + ((Request["product_id"] == null) ? "" : Request["product_id"].Trim());
                break;
            default:
                redirectUrl = "http://www.luqinwenda.com/index.php?app=public&mod=Passport&act=paysuccess2&product_id=" + ((Request["product_id"] == null) ? "" : Request["product_id"].Trim());
                break;
        }

        Response.Redirect(redirectUrl+"&paymethod=yeepay", true);
            
        //Response.Write(callback_result);
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
