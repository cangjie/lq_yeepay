<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PCPay.aspx.cs" Inherits="PCPay" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="demo.css">
    <title>访问易宝支付PC网页收银台</title>
</head>
<body>

    <form id="form1" method="post" runat="server">
    <div class="content2">
        <h2>PC网页收银台示例</h2>
        <ul>
            <li>交易金额： <asp:TextBox ID="orderAmount" runat="server"></asp:TextBox></li>
            <li>商户交易订单号： <asp:TextBox ID="traderOrderID" runat="server"></asp:TextBox></li>
        
            <li>用户身份标识： <asp:TextBox ID="identityID" runat="server"></asp:TextBox></li>
            <li>用户身份标识类型： <asp:TextBox ID="identityType" runat="server"></asp:TextBox></li>
            <li>用户IP： <asp:TextBox ID="userIP" runat="server"></asp:TextBox></li>
            <li>用户UA： <asp:TextBox ID="userUA" runat="server"></asp:TextBox></li>
        
            <li>终端类型： <asp:TextBox ID="terminalType" runat="server"></asp:TextBox></li>
            <li>终端ID： <asp:TextBox ID="terminalID" runat="server"></asp:TextBox></li>
        
        
            <li>商品类别： <asp:TextBox ID="productCatalog" runat="server"></asp:TextBox></li>
            <li>商品名称： <asp:TextBox ID="productName" runat="server"></asp:TextBox></li>
            <li>商品描述： <asp:TextBox ID="productDesc" runat="server"></asp:TextBox></li>
        
            <li>支付成功商户前台回调地址： <asp:TextBox ID="fcallbackURL" runat="server"></asp:TextBox></li>
            <li>支付成功商户后台台回调地址： <asp:TextBox ID="callbackURL" runat="server"></asp:TextBox></li>
        
            <li><asp:Button ID="Button1"  runat="server" AccessKey="A" Text="去PC网页支付" OnClick="PCPay_Click" /></li>
       </ul>
       </div>
    </form>
</body>
</html>
