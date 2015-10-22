<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html>

<script runat="server">

    public string body = "";
    public string productId = "";
    public string detail = "";
    public int fee = 0;
    public int userId = 5;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            body = (Request["body"] == null) ? "" : Request["body"].Trim();
            productId = (Request["product_id"] == null) ? "" : Request["product_id"].Trim();
            detail = (Request["detail"] == null) ? "" : Request["detail"].Trim();
            fee = (Request["total_fee"] == null) ? 0 : int.Parse(Request["total_fee"].Trim());
            userId = (Request["userid"] == null) ? -1* ((new Random()).Next(10000)) :  int.Parse(Request["userid"].Trim());
            string timeStamp = Util.GetTimeStamp();
            Order.CreateOrder(timeStamp+productId.PadLeft(6,'0'), "", "", "", "", body, detail, productId, fee, Request.UserHostAddress.Trim());

            //请求移动终端网页收银台支付

            //一键支付URL前缀
            string apiprefix = APIURLConfig.payMobilePrefix;

            //网页支付地址
            string mobilepayURI = APIURLConfig.webpayURI;

            //商户账户编号
            string merchantAccount = Config.merchantAccount;

            //商户公钥（该商户公钥需要在易宝一键支付商户后台报备）
            string merchantPublickey = Config.merchantPublickey;

            //商户私钥（商户公钥对应的私钥）
            string merchantPrivatekey = Config.merchantPrivatekey;

            //易宝支付分配的公钥（进入商户后台公钥管理，报备商户的公钥后分派的字符串）
            string yibaoPublickey = Config.yibaoPublickey;

            //随机生成商户AESkey
            string merchantAesKey = AES.GenerateAESKey();

            //日志字符串
            StringBuilder logsb = new StringBuilder();
            logsb.Append(DateTime.Now.ToString() + "\n");

            Random ra = new Random();
            int amount = fee;//支付金额为分
            int currency = 156;//币种，默认为156人民币
            //string identityid = "2"//用户身份标识
            int identitytype = 2;

            string orderid = timeStamp + productId.PadLeft(6, '0');
            int orderexpdate = 60;//订单有效期，单位：分钟，例如：60，表示订单有效期为60分钟
            string productcatalog = "1";//商品类别码，商户支持的商品类别码由易宝支付运营人员根据商务协议配置
            string productdesc = detail;
            string productname = body;

            DateTime t1 = DateTime.Now;
            DateTime t2 = new DateTime(1970, 1, 1);
            double t = t1.Subtract(t2).TotalSeconds;
            int transtime = (int)t;//交易发生时间，时间戳，例如：1361324896，精确到秒

            string userip = Request.UserHostAddress.Trim();
            int terminaltype = 3;
            String terminalid = "";

            string paytypes = "1|2";//支付方式（信用卡or借记卡）;1为借记卡；2为信用卡；信用卡、借记卡都支持则传1|2；不传参视为两种方式都支持

            //商户提供的商户后台系统异步支付回调地址
            string callbackurl = "http://yeepay.luqinwenda.com/weixin_payment_callback.aspx" ;
            //商户提供的商户前台系统异步支付回调地址
            string fcallbackurl = "http://yeepay.luqinwenda.com/weixin_payment_finish.aspx";
            //用户浏览器ua
            string userua = Request.UserAgent.Trim();

            SortedDictionary<string, object> sd = new SortedDictionary<string, object>();
            sd.Add("merchantaccount", merchantAccount);
            sd.Add("amount", amount);
            sd.Add("currency", currency);
            sd.Add("identityid", userId.ToString());
            sd.Add("identitytype", identitytype);
            sd.Add("orderid", orderid);
            sd.Add("orderexpdate", orderexpdate);
            productcatalog = "13";
            sd.Add("productcatalog", productcatalog);
            sd.Add("productdesc", productdesc);
            sd.Add("productname", productname);
            sd.Add("transtime", transtime);
            //userip = "123.120.232.19";
            sd.Add("userip", userip);
            sd.Add("terminaltype", terminaltype);
            sd.Add("terminalid", terminalid);
            sd.Add("callbackurl", callbackurl);
            sd.Add("fcallbackurl", fcallbackurl);
            sd.Add("userua", userua);
            sd.Add("paytypes", paytypes);

            //生成RSA签名
            string sign = EncryptUtil.handleRSA(sd, merchantPrivatekey);
            logsb.Append("生成的签名为：" + sign + "\n");

            sd.Add("sign", sign);

            //将网页支付对象转换为json字符串
            string wpinfo_json = Newtonsoft.Json.JsonConvert.SerializeObject(sd);
            logsb.Append("网页支付明文数据json格式为：" + wpinfo_json + "\n");
            string datastring = AES.Encrypt(wpinfo_json, merchantAesKey);
            logsb.Append("网页支付业务数据经过AES加密后的值为：" + datastring + "\n");

            //将商户merchantAesKey用RSA算法加密
            logsb.Append("merchantAesKey为：" + merchantAesKey + "\n");
            string encryptkey = RSAFromPkcs8.encryptData(merchantAesKey, yibaoPublickey, "UTF-8");
            logsb.Append("encryptkey为：" + encryptkey + "\n");

            //打开浏览器访问一键支付网页支付链接地址，请求方式为get
            string postParams = "data=" + HttpUtility.UrlEncode(datastring) + "&encryptkey=" + HttpUtility.UrlEncode(encryptkey) + "&merchantaccount=" + merchantAccount;
            string url = apiprefix + mobilepayURI + "?" + postParams;

            logsb.Append("网页支付链接地址为：" + url + "\n");
            logsb.Append("网页支付链接地址长度为：" + url.Length + "\n");

            //写日志
            
            string m_LogName = Server.MapPath("log.txt");
            if (!System.IO.File.Exists(m_LogName))
            {

                System.IO.FileStream fsnew = System.IO.File.Create(m_LogName);
                fsnew.Close();
            }
            using (System.IO.FileStream fs = System.IO.File.Open(m_LogName, System.IO.FileMode.Append, System.IO.FileAccess.Write))
            {
                using (System.IO.StreamWriter w = new System.IO.StreamWriter(fs))
                {
                    w.WriteLine(logsb.ToString());
                    w.Flush();
                    w.Close();
                }
            }       
             

            //重定向跳转到易宝支付移动终端网页收银台
            Response.Redirect(url);
            
        }
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
