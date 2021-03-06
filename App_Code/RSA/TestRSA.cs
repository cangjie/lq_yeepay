﻿using System;
using System.Collections.Generic;
using System.Text;


 public   class TestRSA
    {
        public static void testRSA()
        {

            /**RSA加密测试,RSA中的密钥对通过SSL工具生成，生成命令如下：
             * 1 生成RSA私钥：
             * openssl genrsa -out rsa_private_key.pem 1024
             *2 生成RSA公钥
             * openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem
             * 
             * 3 将RSA私钥转换成PKCS8格式
             * openssl pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM -nocrypt -out rsa_pub_pk8.pem
             * 
             * 直接打开rsa_public_key.pem（公钥）和rsa_pub_pk8.pem（私钥）文件就可以获取密钥对内容，获取密钥对内容组成字符串时，注意将换行符删除
             * */

            //string publickey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDzOqfNunFxFtCZPlq7fO/jWwjqmTvAooVBB4y87BizSZ9dl/F7FpAxYc6MmX2TqivCvvORXgdlYdFWAhzXOnIUv9OGG///WPLe9TMs9kIwAZ/APUXauvC01oFLnYkzwPlAh0tQ1Au9arTE/OG1V1dKgf8BXHLPhKL4BmGBEUZBtQIDAQAB";
            //string privatekey = "MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBAPM6p826cXEW0Jk+Wrt87+NbCOqZO8CihUEHjLzsGLNJn12X8XsWkDFhzoyZfZOqK8K+85FeB2Vh0VYCHNc6chS/04Yb//9Y8t71Myz2QjABn8A9Rdq68LTWgUudiTPA+UCHS1DUC71qtMT84bVXV0qB/wFccs+EovgGYYERRkG1AgMBAAECgYEA2PmnPdgnYKnolfvQ9tXiLaBFGPpvGk4grz0r6FB5TF7N4rErwxECunq0xioaowK4HPc40qHd2SvkkWQ7FCjYIDsnMk1oOhxNKn0J3FG0n5Cg1/dFai4eoXHs/nKn3SVZ8YZC1T2cMtN2srectLqNqhB8aQEe8xmykyUlUpg/qmECQQD9vkwjUotG5oUUrOj6etcB4WcdyyH0FtThKgyoJUDwgBv6lGGzWyFJEREvp47IgV+FgC7zeP2mL4MhgnD3tNCZAkEA9WRrjOLBNc379XZpoDsH7rZjobVvhnTrEuRDx/whqZ+vk64EPrEW81XYh647bAbJlFn2jPhY+IUHkrxFEFT/fQJBAMoLNOULXQtfkqgb5odMONeue0Ul8itB4tBHgzyALW1TFPQ6InGGJsLfbCfd67uMCFts7fXAaXhibK/KBdm3iEECQQChwVAjzlUN4nnzk9qMhFz2PcPvFGovd2J9UXpcmRaXeWuDLXIe4Rz/ydaxmWgSDWdTIvoicpIzP31+fBwKZ/0BAkEAy0bh4weKmYF29//rK0sxmY8RtqkQeFrwWbqx1daa1w0DfWlNSvy47zyW1G5/AdZU6JSpXxlxdlM/HSDw+v7kcA==";
            string publickey = Config.merchantPublickey;
            string privatekey = Config.merchantPrivatekey;
		
            //加密字符串
            string data = "1234567890123456";

            Console.WriteLine("加密前字符串内容："+data);
            //加密
            string encrypteddata = RSAFromPkcs8.encryptData(data, publickey, "UTF-8");
            Console.WriteLine("加密后的字符串为：" + encrypteddata);
            Console.WriteLine("解密后的字符串内容：" + RSAFromPkcs8.decryptData(encrypteddata, privatekey, "UTF-8"));

            //签名
            string signdata = "YB010000001441234567286038508081299";
            Console.WriteLine("签名前的字符串内容：" + signdata);
            string sign = RSAFromPkcs8.sign(signdata, privatekey, "UTF-8");
            Console.WriteLine("签名后的字符串：" + sign);

            Console.WriteLine("RSA算法测试结束");

            Console.ReadLine();
        }
    }

