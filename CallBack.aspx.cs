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
using System.IO;

public partial class CallBack : System.Web.UI.Page
{
    
    /// <summary>
    /// 接收易宝支付回调示例
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["data"] == null || Request.QueryString["encryptkey"] == null)
            {
                Response.Write("参数不正确！");
            }
            string data = Request.QueryString["data"].ToString(); //回调中的参数data
            string encryptkey = Request.QueryString["encryptkey"].ToString();//回调中的参数encryptkey
            DataLabel.Text = data;
            EncryptKeyLabel.Text =  encryptkey;

            string callback_result = YJPayUtil.checkYbCallbackResult(data, encryptkey);//解密易宝支付回调结果
            CallBackResultLabel.Text = callback_result;
        }
        catch (Exception err)
        {
            Response.Write("支付失败！");
            return;
        }

    }
}
