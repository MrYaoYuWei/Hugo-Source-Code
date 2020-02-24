---
title: "Nessus安装"
date: 2020-02-24T21:43:23+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---



安装nessus，利用nessus进行漏洞扫描



<!--more-->



## 安装步骤



* 下载地址

  >因为NESSUS从7版本开始增加了远程调用的认证，MSF调用NESSUS时会报错，所以我们选择下 载6.12版本的64位deb包，如果不使用MSF调用NESSUS，下载任何一个版本都可以

  ~~~
  https://www.tenable.com/downloads/nessus
  ~~~

* rz命令上传安装包

* 编译安装安装包

~~~
dpkg -i Nessus-6.12.1-debian6_amd64.deb
~~~

* 开启nessus服务

~~~
/etc/init.d/nessus start
https://192.168.1.53:8834 
~~~

* 离线下载

  ~~~
  https://plugins.nessus.org/v2/offline.php
  ~~~

* 申请激活码

~~~
https://www.tenable.com/products/nessus/nessus-essentials
~~~

* 下载插件安装包
* rz命令上传插件安装包

* nessuscli命令安装 

  ~~~
  ps -aux | grep nessus
  /opt/nessus/sbin/nessuscli  help
  /opt/nessus/sbin/nessuscli  update all-2.0.tar.gz
  ~~~

* 重启nessus服务

~~~
/etc/init.d/nessusd restart
ps -aux | grep nessus
~~~