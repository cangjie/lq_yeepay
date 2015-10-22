
********SDK说明**********

1、该工程为web工程，可以直接部署到IIS下，也可以在VS2008以上版本中执行，谢谢！
2、首页为Default.aspx，访问地址如：http://localhost:53554/yb_pay_mobile/Default.aspx
3、移动终端网页支付示例文件为MobilePay.aspx.cs
4、PC网页支付示例文件为PCPay.aspx.cs
5、绑卡支付示例文件为App_Code/Test/BindPayTest.cs，绑卡支付之前请先通过获取绑卡关系列表（示例为BindListTest.cs）获取有效的绑卡关系
6、支付回调示例文件为CallBack.aspx.cs

********主要文件说明*********

AES
	AES.cs	---	AES加密算法工具类
	
config
	APIURLConfig.cs	---	为一键支付API请求地址配置文件
	Config.cs	---	为商户RSA密钥设置配置文件（可通过 http://mobiletest.yeepay.com/file/caculate/to_rsa 快速生成RSA密钥对）

Entity
	RespondJson.cs	---	一键支付返回的结果JSON对象

RSA
	RSA.cs	---	RSA加密算法工具类
	
Util
	EncryptUtil.cs	---	适用于一键支付的RSA签名工具类
	HttpUtil.cs	---	Http请求工具类
	YJPay.cs	---	一键支付接口请求SDK
	YJPayUtil.cs	---	一键支付接口请求工具类