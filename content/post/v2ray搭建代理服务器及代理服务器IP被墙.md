---
title: "V2ray搭建代理服务器及代理服务器IP被墙"
date: 2020-02-07T20:19:23+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---

V2ray搭建代理服务器

<!--more-->

## 部署v2ray-ws-tls代理服务器

* 测试IP地址是否被墙

  ![](http://junmoxiao.org.cn/20200207202947.png)

* 注册账号   Zipcode：85001

  >https://www.namesilo.com/?rid=2b28433wm

![](http://junmoxiao.org.cn/20200207205617.png)

* 搜索你想要的域名，输入关键字即可

  ![](http://junmoxiao.org.cn/20200207205751.png)



![](http://junmoxiao.org.cn/20200207205823.png)

![](http://junmoxiao.org.cn/20200207205847.png)

![](http://junmoxiao.org.cn/20200207205921.png)

![](http://junmoxiao.org.cn/20200207205947.png)

* 添加DNS解析  添加2条主机记录（A记录）@和www

![](http://junmoxiao.org.cn/20200207210048.png)

![](http://junmoxiao.org.cn/20200207210122.png)

![](http://junmoxiao.org.cn/20200207210153.png)

![](http://junmoxiao.org.cn/20200207210329.png)



​        ![](http://junmoxiao.org.cn/20200207210458.png)

![](http://junmoxiao.org.cn/20200207210521.png)

* 测试解析 ping 域名
* 部署v2ray 

~~~
bash <(curl -s -L https://git.io/v2ray.sh) 
~~~

![](http://junmoxiao.org.cn/20200207210649.png)

>安装

![](http://junmoxiao.org.cn/20200207210724.png)

>选择WebSocket+TLS

![](http://junmoxiao.org.cn/20200207210813.png)

>端口默认回车即可



>输入域名，这里设置的域名根据你DNS中解析到当前VPS的域名进行设置，如果你解析了@就直接 写域名，如果你只解析了二级域名至VPS，就填写你的二级域名



>确保已经解析





>开启网站伪装和分流



![](http://junmoxiao.org.cn/20200207211111.png)

>设置伪装的网址https://www.metacafe.com/ 



>不开启广告拦截，用处不大还影响性能



>不配置Shadowsocks



>获取URL地址 v2ray url



* 下载v2ray客户端 ：https://github.com/2dust/v2rayN/releases

  >复制URL的地址到v2ray客户端

![](http://junmoxiao.org.cn/20200207211322.png)

![](http://junmoxiao.org.cn/20200207211401.png)

![](http://junmoxiao.org.cn/20200207211420.png)

![](http://junmoxiao.org.cn/20200207211555.png)

