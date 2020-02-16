---
title: "VMTools安装"
date: 2020-01-13T19:49:02+08:00
author: 姚先生
categories: ['Linux']

---

VMTools实现windows和Linux文件共享和命令复制和粘贴...

<!--more-->

## CentOS7.X安装VMTools

* 直接粘贴命令在windows和Linux质检

* 设置windows和Linux共享文件

* VM->虚拟机->安装VMTools工具

* 复制压缩包到/opt目录

* 解压压缩包

* 进入目录执行vmware-install.pl

  ![](http://junmoxiao.org.cn/20200113195727.png)

  

  ![](http://junmoxiao.org.cn/20200113201431.png)

  

~~~
pwd
cp VMwareTools-10.3.10-13959562.tar.gz /opt/
cd /opt
ls
tar -zxvf VMwareTools-10.3.10-13959562.tar.gz
ls
cd vmware-tools-distrib/
ls -ahl
./vmware-install.pl
一直按Enter键

~~~

## Windows和CentOS7.X实现文件共享



![](http://junmoxiao.org.cn/20200113201800.png)

![](http://junmoxiao.org.cn/20200113201837.png)![](http://junmoxiao.org.cn/20200113201948.png)