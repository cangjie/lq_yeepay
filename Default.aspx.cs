using System;
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

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void BindList_Click(object sender, EventArgs e)
    {
        //执行获取绑卡关系列表接口调用示例代码
        string log=BindListTest.testBindList();
        LogLabel.Text = log; 
    }

    protected void BindPay_Click(object sender, EventArgs e)
    {
        //执行绑卡支付接口调用示例代码
        string log=BindPayTest.testBindPay();
        LogLabel.Text = log; 
    }
    protected void QueyPayOrder_Click(object sender, EventArgs e)
    {
        //执行交易订单查询接口调用示例代码
        string log = QueryPayInfoTest.testQueryPayInfo();
        LogLabel.Text = log;
    }
    protected void QueyPayResult_Click(object sender, EventArgs e)
    {
        //执行支付结果查询接口调用示例代码
        string log = QueryPayResultTest.testQueryPayResult();
        LogLabel.Text = log;
    }
    protected void Refund_Click(object sender, EventArgs e)
    {
        //执行退款接口调用示例代码
        string log = DirectFundTest.testDirectRefund();
        LogLabel.Text = log;
    }
    protected void QueryRefund_Click(object sender, EventArgs e)
    {
        //执行退款查询接口调用示例代码
        string log = QueryRefundInfoTest.testQueryRefundInfo();
        LogLabel.Text = log;
    }
    protected void ClearPay_Click(object sender, EventArgs e)
    {
        //执行获取消费清算对账单接口调用示例代码
        string log = ClearPayDataTest.testClearPayData();
        LogLabel.Text = log;
    }
    protected void ClearRefund_Click(object sender, EventArgs e)
    {
        //执行获取消费清算对账单接口调用示例代码
        string log = ClearRefundDataTest.testClearRefundData();
        LogLabel.Text = log;
    }
}
