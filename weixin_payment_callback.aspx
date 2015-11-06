<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string data = Request["data"].ToString(); //回调中的参数data
        string encryptkey = Request["encryptkey"].ToString();//回调中的参数encryptkey
        string callback_result = YJPayUtil.checkYbCallbackResult(data, encryptkey);

        JavaScriptSerializer serializer = new JavaScriptSerializer();
        Dictionary<string, object> json = (Dictionary<string, object>)serializer.DeserializeObject(callback_result);
        object orderId;
        json.TryGetValue("orderid", out orderId);

        Order order = new Order(orderId.ToString());
        order.Status = 2;

        Response.Redirect(order.GetCallBackUrl() + "&paymethod=yeepay", true);
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
