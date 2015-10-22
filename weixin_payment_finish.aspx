<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string data = Request.QueryString["data"] == null ? "nLra%2B8WD7rst9cCE48x6%2FH0Upv61BpSeb0bGCoNIRqYo6KFaZD9qKliJ%2F8awCgaQMFD1imwAvNR1nnYv7FWCAABYVOOW7UuAQAKBtUllmrfoakcvm%2Bq%2B4MdXNmn8XRTTtxlTQy1Qr0u1xt9zIPL1vL9QTEaeXWn4iAnTIG%2BBMCSS6BAoMejY4uxTzB6NZrUdYCKx32xHn0BPCd2ifVOj2ZAfFaSu1dO6jkYBMPDPAsRW0SlMLNNbOYZsSV1L3V7AofYVrBLkgKXjrOI3sP0hPCdlByDKqCbpn7LY5gwnfU12OIq9hlcHXNdkzuI13XPoZl2hqM5as%2B5lKavPAGK0YolpDxfO1lAsrhZDLpG%2FTTjpagc2AB2v8Wx2uM9%2BIsCLiDJ6WAvIR3lbgfvxoyYXulR%2BkuOSzU2oPuizzBxymMpSEwjIW5aAvsOXM8t4Gq7225r1jxu%2FxLfjKzyFp6zC9lc4Z4tSHVKk2nkzvKU%2BlSw%3D" : Request.QueryString["data"].ToString(); //回调中的参数data
        string encryptkey = Request.QueryString["encryptkey"] == null ? "cDowh3t%2F9%2FHpXbryQxb0%2FZ%2Frbp6Lk%2FI5osdlgR6GmyiLTIRaohXgbzK8PH7Lq7Lr7rA6Sa3eO6%2Fh96LJ8fHNA6PTH58pxiRrwfE0cDj5xwmkALDDahunHPize1UK2zLnpDMNAPnccdQJ9oNJATGzJ%2FyUUCksY3X0jP9Z%2BTuov3o%3D" : Request.QueryString["encryptkey"].ToString();//回调中的参数encryptkey
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

        string productId = order._fields["order_product_id"].ToString().Trim();
        
        
        switch (order._fields["order_body"].ToString().Trim())
        {
            case "“放飞梦想我能行”知心姐姐北京精品营再次出发":
                redirectUrl = "http://www.luqinwenda.com/index.php?app=public&mod=Passport&act=paysuccess2&product_id=" + productId;
                break;
            case "卢勤问答平台官方书城":
                redirectUrl = "http://mall.luqinwenda.com/paySuccess.aspx?product_id=" + productId;
                break;
            case "卢勤问答平台官方夏令营":
                redirectUrl = "http://mall.luqinwenda.com/paySuccess.aspx?product_id=" + productId;
                break;
            default:
                redirectUrl = "http://www.luqinwenda.com/index.php?app=public&mod=Passport&act=paysuccess2&product_id=" + productId;
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