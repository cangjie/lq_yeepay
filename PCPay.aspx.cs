using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Text;

public partial class PCPay : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //加载页面时初始化支付需要的业务明文参数

        orderAmount.Text = "2";//默认的交易金额

        Random ra = new Random();
        traderOrderID.Text = "1234567" + 50 * ra.Next();//商户订单号

        identityID.Text = "user_" + 50 * ra.Next();//用户身份标识
        identityType.Text = "2";//用户身份标识类型，0为IMEI，1为MAC，2为用户ID，3为用户Email，4为用户手机号，5为用户身份证号，6为用户纸质协议单号
        userIP.Text = getIp();//获取用户IP地址
        userUA.Text = Request.UserAgent;//获取用户UA

        terminalType.Text = "3";//终端类型，0、IMEI；1、MAC；2、UUID；3、other，如果终端类型未知的话，那么就传other
        terminalID.Text = "nothing";//终端类型未知，终端标识可以传任意字符串

        productCatalog.Text = "1";//1代表虚拟商品，商品类别必须与协议保持一致。商品类别编码请见http://mobiletest.yeepay.com/file/doc/pubshow?doc_id=14#hm_27。
        productName.Text = "玉米加农炮";//商品名称
        productDesc.Text = "植物大战僵尸道具";//商品描述

        fcallbackURL.Text = "http://mobiletest.yeepay.com/demo/pay/callback";//支付成功后商户前台提供的回调的地址，fcallbackURL.Text = "http://mobiletest.yeepay.com/demo/pay/callback";

        callbackURL.Text = "http://mobiletest.yeepay.com/demo/pay/callback";//支付成功后商户后台提供的回调的地址，fcallbackURL.Text = "http://mobiletest.yeepay.com/demo/pay/callback";


    }

    protected void PCPay_Click(object sender, EventArgs e)
    {
        //请求移动终端网页收银台支付

        //一键支付URL前缀
        string apiprefix = APIURLConfig.payWebPrefix;

        //网页支付地址
        string pcpayURI = APIURLConfig.pcwebURI;

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
        int amount = int.Parse(orderAmount.Text);//支付金额为分
        int currency = 156;//币种，默认为156人民币
        string identityid = identityID.Text;//用户身份标识
        int identitytype = int.Parse(identityType.Text);

        string orderid = traderOrderID.Text;
        int orderexpdate = 60;//订单有效期，单位：分钟，例如：60，表示订单有效期为60分钟
        string productcatalog = productCatalog.Text;//商品类别码，商户支持的商品类别码由易宝支付运营人员根据商务协议配置
        string productdesc = productDesc.Text;
        string productname = productName.Text;

        DateTime t1 = DateTime.Now;
        DateTime t2 = new DateTime(1970, 1, 1);
        double t = t1.Subtract(t2).TotalSeconds;
        int transtime = (int)t;//交易发生时间，时间戳，例如：1361324896，精确到秒

        string userip = userIP.Text;
        int terminaltype = int.Parse(terminalType.Text);
        String terminalid = terminalID.Text;

        string paytypes = "1|2";//支付方式（信用卡or借记卡）;1为借记卡；2为信用卡；信用卡、借记卡都支持则传1|2；不传参视为两种方式都支持


        //商户提供的商户后台系统异步支付回调地址
        string callbackurl = callbackURL.Text;
        //商户提供的商户前台系统异步支付回调地址
        string fcallbackurl = fcallbackURL.Text;
        //用户浏览器ua
        string userua = userUA.Text;

        SortedDictionary<string, object> sd = new SortedDictionary<string, object>();
        sd.Add("merchantaccount", merchantAccount);
        sd.Add("amount", amount);
        sd.Add("currency", currency);
        sd.Add("identityid", identityid);
        sd.Add("identitytype", identitytype);
        sd.Add("orderid", orderid);
        sd.Add("orderexpdate", orderexpdate);
        sd.Add("productcatalog", productcatalog);
        sd.Add("productdesc", productdesc);
        sd.Add("productname", productname);
        sd.Add("transtime", transtime);
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
        string url = apiprefix + pcpayURI + "?" + postParams;

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

        //重定向跳转到易宝支付PC网页收银台。另外，商户也可以通过页面自动POST提交方式访问易宝支付收银台
        Response.Redirect(url);


    }

    private static string getIp()
    {
        if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_VIA"] != null)
            return System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].Split(new char[] { ',' })[0];
        else
            return System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
    }
}


