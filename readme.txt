
********SDK˵��**********

1���ù���Ϊweb���̣�����ֱ�Ӳ���IIS�£�Ҳ������VS2008���ϰ汾��ִ�У�лл��
2����ҳΪDefault.aspx�����ʵ�ַ�磺http://localhost:53554/yb_pay_mobile/Default.aspx
3���ƶ��ն���ҳ֧��ʾ���ļ�ΪMobilePay.aspx.cs
4��PC��ҳ֧��ʾ���ļ�ΪPCPay.aspx.cs
5����֧��ʾ���ļ�ΪApp_Code/Test/BindPayTest.cs����֧��֮ǰ����ͨ����ȡ�󿨹�ϵ�б�ʾ��ΪBindListTest.cs����ȡ��Ч�İ󿨹�ϵ
6��֧���ص�ʾ���ļ�ΪCallBack.aspx.cs

********��Ҫ�ļ�˵��*********

AES
	AES.cs	---	AES�����㷨������
	
config
	APIURLConfig.cs	---	Ϊһ��֧��API�����ַ�����ļ�
	Config.cs	---	Ϊ�̻�RSA��Կ���������ļ�����ͨ�� http://mobiletest.yeepay.com/file/caculate/to_rsa ��������RSA��Կ�ԣ�

Entity
	RespondJson.cs	---	һ��֧�����صĽ��JSON����

RSA
	RSA.cs	---	RSA�����㷨������
	
Util
	EncryptUtil.cs	---	������һ��֧����RSAǩ��������
	HttpUtil.cs	---	Http���󹤾���
	YJPay.cs	---	һ��֧���ӿ�����SDK
	YJPayUtil.cs	---	һ��֧���ӿ����󹤾���