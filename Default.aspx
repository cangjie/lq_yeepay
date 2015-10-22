<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="demo.css">
    <title>一键支付接口调用示例</title>
</head>
<body>
    <form id="form1" runat="server">
    <h2>易宝支付一键支付接口调用示例</h2>
    <h3>网页收银台</h3>
    <div class="content2">
        <a href="<%=Request.ApplicationPath%>/MobilePay.aspx">移动终端网页收银台调用示例</a> <br />
        <a href="<%=Request.ApplicationPath%>/PCPay.aspx">PC网页收银台调用示例</a><br />
    </div>
    <div class="content2">
    
        <h3>其他接口</h3>
        <ul>
            
            <li><asp:Button ID="Button1"  runat="server" AccessKey="A" Text="获取绑卡关系列表示例" OnClick="BindList_Click" />
            <asp:Button ID="Button2"  runat="server" AccessKey="A" Text="绑卡支付示例" OnClick="BindPay_Click" /></li>
            <li><asp:Button ID="Button3"  runat="server" AccessKey="A" Text="交易订单查询示例" OnClick="QueyPayOrder_Click" /></li>
            <li><asp:Button ID="Button4"  runat="server" AccessKey="A" Text="支付结果查询示例" OnClick="QueyPayResult_Click" /></li>
            <li><asp:Button ID="Button5"  runat="server" AccessKey="A" Text="退款示例" OnClick="Refund_Click" />
            <asp:Button ID="Button6"  runat="server" AccessKey="A" Text="退款查询示例" OnClick="QueryRefund_Click" /></li>
            <li><asp:Button ID="Button7"  runat="server" AccessKey="A" Text="获取消费清算对账单示例" OnClick="ClearPay_Click" /></li>
            <li><asp:Button ID="Button8"  runat="server" AccessKey="A" Text="获取退款清算对账单示例" OnClick="ClearRefund_Click" /></li>
            
        </ul>
            
    </div>
    <div class="content2">
        <asp:Label ID="LogLabel" runat="server" Text=""></asp:Label>
    </div>
    </form>
</body>
</html>
