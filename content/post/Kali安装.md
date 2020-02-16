---
title: "Kali安装"
date: 2020-02-06T12:40:40+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']

---

how to install kali linux

<!--more-->

##  Kali Linux 简介

* Kali Linux是一个基于Debian的 Linux发行版，旨在迚行高级渗透测试和安全审计。

* 包括 600多种渗透测试工具

* 免费

* 开源

* 广泛的无线设备支持

* 安全环境开发 :  Kali Linux团队由一小部分人组成，他们是唯一可信任的提交包并不存储 库交互的人，所有这些都是使用多个安全协议完成的

* GPG签名包和存储库 ： Kali Linux中的每个包都由构建和提交它的每个开发人员签名，并且存 储库随后也会对包签名 

* ARMEL和ARMHF支持

  

##   使用VM虚拟机安装Kali 

![](http://junmoxiao.org.cn/20200206141014.png)

![](http://junmoxiao.org.cn/20200206144028.png)

![](http://junmoxiao.org.cn/20200206144820.png)

## Kali安装VM-Tools

~~~
apt update
apt install open-vm-tools-desktop fuse
reboot 
~~~

![](http://junmoxiao.org.cn/20200206145206.png)

> apt 和apt-get区别
>
> *  apt 可以看作 apt-get 和 apt-cache 命令的子集, 可以为包管理提供必要的命令选项 
>
> * apt-get 虽然没被弃用，但作为普通用户，还是应该首先使用 apt

## 配置Kali的apt 源

~~~
vim  /etc/apt/sources.list 
deb https://mirrors.aliyun.com/kali kali-rolling main non-free contrib
deb-src https://mirrors.aliyun.com/kali kali-rolling main non-free contrib 
apt update 
~~~

![](http://junmoxiao.org.cn/20200206145859.png)

>
>
>* Kali Rolling: 是Kali 的即时更新版，只要 Kali中有更新，更新包就会放入 Kali Rolling中，供用户 下载使用。它为用户提供了一个稳定更新的版本，同时会带有最新的更新安装包。这个是我们最常用的源
>
>* 在Kali Rolling下有 3类软件包：main、non-free和contrib

>apt update ，apt upgrade 和apt dist-upgrade 的区别 
>
>* apt update 的作用是从/etc/apt/sources.list 文件中定义的源中获取的最新的软件包列表。 即运行 apt update并没有更新软件，而是相当于windows下面的检查更新，获取的是软件的状态
>* apt upgrade 则是更据 update命令获取的最新的软件包列表，去真正地更新软件，系统将现有的 Package升级,如果有相依性的问题,而此相依性需要安装其它新的 Package 戒影响到其它 Package的相依性时,此 Package就不会被升级,会保留下来.
>* apt dist-upgrade:可以聪明的解决相依性的问题,如果有相依性问题,需要安装/移除新的Package,就会 试着去安装/移除它

## Kali虚拟机快照

![image-20200206150525492](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200206150525492.png)