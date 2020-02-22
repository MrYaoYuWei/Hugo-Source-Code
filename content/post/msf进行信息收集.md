---
title: "Msf进行信息收集"
date: 2020-02-21T19:51:36+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---

Metasploit框架使用常用协议进行信息收集获取服务器的硬件信息，系统用户信息、进程信息，系统版本信息，敏感信息，文件信息

<!--more-->



## 基于TCP协议收集信息

* 使用nmap插件对目标机进行TCP扫描

>msf5 > db_nmap 
>
>[*] Usage: db_nmap [--save | [--help | -h]] [nmap options]
>
>e.g  db_nmap  -sV  -O 192.168.1.131

![](http://junmoxiao.org.cn/20200221200345.png)

* 端口查询portscan模块对目标机进行TCP协议扫描

![](http://junmoxiao.org.cn/20200221200724.png)

## 基于ARP协议收集信息

* arp_sweep模块查询目标地址段的物理地址

![](http://junmoxiao.org.cn/20200221200923.png)

## 基于FTP协议收集信息

* psnuffle模块监听ftp服务账号和密码  apt install lftp      使用lftp命令连接

  ![](http://junmoxiao.org.cn/20200222164522.png)

  ![](http://junmoxiao.org.cn/20200221201205.png)

* 查询ftp服务版本号模块

  >search ftp_version
  >
  >auxiliary/scanner/ftp/ftp_version

* ftp2.3.4后门漏洞模块

  > search exploit/unix/ftp/vsftpd_234_backdoor 

*  基于ftp服务暴力破解模块

  >search ftp_login
  >
  >使用auxiliary/scanner/ftp/ftp_login模块进行暴力破解

##  基于SNMP协议收集信息

>简单网络管理协议（SNMP，Simple Network Management Protocol），由一组网络管理的标准组成，包含一个应用层协议（application layer protocol）、数据库模型（database schema）和一组资源对象。该协议能够支持网络管理系统，用以监测连接到网络上的设备是否有任何引起管理上关注的情况

>目标机开启snmp服务 （默认不开启）端口号161
>
>vim /ect/default/snmpd
>
>netstat -antup | grep 161
>
>使用auxiliary/scanner/snmp/snmp_enum 模块扫描目标机的详细情况
>
>![](http://junmoxiao.org.cn/20200222164158.png)
>
>![](http://junmoxiao.org.cn/20200222164232.png)

>基于SNMP暴力破解
>
>使用auxiliary/scanner/snmp/snmp_login模块进行暴力破解snmp服务

## 基于SMB协议收集信息

>SMB概述服务器消息块（Server Message Block，缩写为SMB），又称网络文件共享系统 （Common Internet File System，缩写为CIFS），一种应用层网络传输协议，由微软开发，主要功能 是使网络上的机器能够共享计算机文件、打印机、串行端口和通讯等资源

> 基于SMB协议扫描目标机系统版本号 
>
> auxiliary/scanner/smb/smb_version模块进行扫描
>
> set RHOSTS 192.168.1.180, 192.168.1.131
>
>  192.168.1.180后面的逗号和 192.168.1.131之间是有空格的 ![](http://junmoxiao.org.cn/20200222165248.png)

>基于SMB协议扫描目标机的系统用户信息 
>
>使用auxiliary/scanner/smb/smb_lookupsid模块进行扫描
>
>如果你不配置用户，就扫描不到信息，配置一下用户信息
>
>![](http://junmoxiao.org.cn/20200222170114.png)

>基于SMB协议扫描目标机的共享文件信息
>
>使用 auxiliary/scanner/smb/smb_enumusers模块进行用户的共享文件扫描
>
>如果你不配置用户，就扫描不到共享文件信息，配置一下用户信息

>基于SMB协议暴力破解
>
>使用auxiliary/scanner/smb/smb_login模块进行暴力破击网络文件共享系统服务

## 基于SSH协议收集信息

>基于SSH协议扫描目标机SSH版本号
>
>使用auxiliary/scanner/ssh/ssh_version 模块进行扫描SSH版本号
>
>![](http://junmoxiao.org.cn/20200222171730.png)

>基于SSH协议暴力破解SSH服务
>
>使用auxiliary/scanner/ssh/ssh_login 模块进行暴力破解
>
>![](http://junmoxiao.org.cn/20200222171956.png)