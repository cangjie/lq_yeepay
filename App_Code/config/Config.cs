using System;
using System.Collections.Generic;
using System.Text;

public class Config
{
    
        static Config()
        {
            //商户账户编号
            merchantAccount = "10012431041";

            //商户RSA密钥对——公钥，(请见“RSA密钥对生成说明.txt”)，该公钥需要在商户后台向易宝支付报备
            //商户后台(测试环境http://mobiletest.yeepay.com/merchant,正式环境http://www.yeepay.com)
            merchantPublickey =     "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3809NRaibKhjetwWh+WIHT2P4mJhgTulVg38+Pc6udg7hSM0w5QmxdcvWZ5wYCgIXJiPrRR2aLSi3edJW6J0aL/tyhg9DXHVZnBOhI3+8UV8MDyeXV9aulfI15Bf8xYV+9RFP+UWVVr0gBQvHhtn40jU9YpQlXkG21fAEZCnrUwIDAQAB";

            //商户RSA密钥对——私钥，(请见“RSA密钥对生成说明.txt”)
            merchantPrivatekey =    "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALfzT01FqJsqGN63BaH5YgdPY/iYmGBO6VWDfz49zq52DuFIzTDlCbF1y9ZnnBgKAhcmI+tFHZotKLd50lbonRov+3KGD0NcdVmcE6Ejf7xRXwwPJ5dX1q6V8jXkF/zFhX71EU/5RZVWvSAFC8eG2fjSNT1ilCVeQbbV8ARkKetTAgMBAAECgYALNd7NXMNrwWMGn6zOND6PJ312NwaCSAzcU0k759RiuXsqq58lra+rivxDMslGhcWe14o02l91d+8VT21MMpzwUwsvDqwaqIFHsIsZkxAMBQ141e/36riEmZDJCDluKPYDu3/B08itOpVfqo2mOnNLhM+CakKm/eGd0Ndm6k4tQQJBAO/QZx1gJ6ul1CizShlEK5c31G/LGeKpjCt2GDCktz33rGQ8wHFqAWSNldybj15Riphru6igcSwPpETeZZNC+5ECQQDEXayOTFCYVHG4a96oMJmAf84oebotO4kXtkbqB9JjQ67UzhDn+DpjFaD7Gib5Y4Ne5aFnlYfOrez6G8NenN6jAkAoJw+sxnW98qUEL4i/lD9sMUfbc/kgj1zNxhckxd98e6Scn+Nk2efjyyUFa/JkS2jWPmuMP1jTlMbfVRFSx8tRAkEAwDaNjTDoh2PJeWOlrO79own3rCkTc+leFaboHXeQmngLL+WSKO8TgCAQ1xrPYbjmREL0zmdRa59WY7A/emKFjwJBALRKFfzkJ4Z9qgUQkqa5spskIzQ3WYWTvOw9yOag0r74q22wg8y+88WFAqYXMJnV2BTTHRiOduwZdTkizo50zC8=";

            //易宝支付分配的公钥，该公钥由商户进入商户后台先上报自己的公钥再获取，商户后台目录为（产品管理——RSA公钥管理）
            //商户后台(测试环境http://mobiletest.yeepay.com/merchant,正式环境http://www.yeepay.com)
            yibaoPublickey =        "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCDNsRtQU5fi3+Yr4wQD9v02vmze+gD6qzM6RiQ4GgbuU/0x3+wSM23+qTJ3uSoWA+eLNm/5wrU6X7qGUOp0oZwcKDkg1aH6fxwWRfm63xyq+RAkElKgxDEQkTJd/6LQrJFmHZDrbk6sS05fq+JeYK6e5YQ/8ev3+ZdV6Kh2PRb6wIDAQAB";
        }

        public static string merchantAccount
        { get; set; }

        public static string merchantPublickey
        { get; set; }

        public static string merchantPrivatekey
        { get; set; }

        public static string yibaoPublickey
        { get; set; }
    }

