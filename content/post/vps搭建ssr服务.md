---
title: "Vps搭建ssr服务"
date: 2020-02-06T16:50:23+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---

搭建ssr服务

<!--more-->

## Kali配置静态IP地址

~~~
ifconfig
vim /etc/network/interfaces
auto eth0 
iface eth0 inet static 
address 192.168.1.53 
netmask 255.255.255.0 
gateway 192.168.1.1
~~~

![](http://junmoxiao.org.cn/20200206151602.png)![](http://junmoxiao.org.cn/20200206151650.png)

>* iface eth0 inet static #配置eth0使用静态地址 
>* address 192.168.1.53 #配置eth0的固定IP地址，网段要和物理机所在网段一样,且 此IP没有被其他人使用
>* netmask 255.255.255.0 #配置子网掩码
>* gateway 192.168.1.1 #配置网关

~~~
 vim /etc/resolv.conf #插入DNS地址
 systemctl restart networking
~~~

![](http://junmoxiao.org.cn/20200206151947.png)

![](http://junmoxiao.org.cn/20200206152311.png)

## Kali配置sshd服务并使用xshell连接 

~~~
vim /etc/ssh/sshd_config  
systemctl restart ssh.service
update-rc.d ssh enable
~~~

![](http://junmoxiao.org.cn/20200206152625.png)

![](http://junmoxiao.org.cn/20200206153329.png)

![](http://junmoxiao.org.cn/20200206153358.png)

## 购买一台国外的VPS服务器搭建ssr服务

>* 官方网址：https://bwh88.net/aff.php?aff=47237

![](http://junmoxiao.org.cn/20200206153916.png)

>* 优惠码：BWH3HYATVBJW 

![](http://junmoxiao.org.cn/20200206154729.png)

## 部署Shadowsocks代理服务器 

~~~
yum install wget -y
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh
chmod +x shadowsocksR.sh
./shadowsocksR.sh 2>&1 | tee shadowsocksR.log
~~~

>* ./表示执行当前路径下的脚本 
>* 2>&1 表示将标准错误输出重定向到标准输出，这样我们把输出结果存放到日志文件便于排错 
>* | 管道符 将程序前面的输出结果作为后面程序的输入
>* tee 输出到标准输出的同时，保存到文件file中。如果文件不存在，则创建；如果已经存在，则覆盖之

![](http://junmoxiao.org.cn/20200206160356.png)

![](http://junmoxiao.org.cn/20200206160429.png)

![](http://junmoxiao.org.cn/20200206160454.png)

![](http://junmoxiao.org.cn/20200206160533.png)

![](http://junmoxiao.org.cn/20200206160625.png)

![](http://junmoxiao.org.cn/20200206160830.png)

## 使用Windows客户端访问远程代理服务器

>* 客户端下载地址: https://github.com/shadowsocksrr/shadowsocksr-csharp/releases

![image-20200206161237936](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200206161237936.png)

![](http://junmoxiao.org.cn/20200206161317.png)



![](http://junmoxiao.org.cn/20200206161413.png)

## 配置Google BBR加速ssr服务器的网络 

>* GoogleBBR就是谷歌公司提出的一个开源TCP拥塞控制的算法。在最新的linux4.9 及以上的内核 版本中已被采用。对于该算法的分析，ssr不经过其它的任何的优化就能轻松的跑满带宽。BBR 是 Google 提出的一种新型拥塞控制算法，可以使 Linux 服务器显著地提高吞吐量和减少 TCP 连接的延迟。 
>* BBR解决了两个问题： 在有一定丢包率的网络链路上充分利用带宽。非常适合高延迟，高带宽的网络链路。 降低网络链路上的buffer占用率，从而降低延迟。非常适合慢速接入网络的用户。
>
>

~~~
wget -N --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh
sysctl net.ipv4.tcp_congestion_control
~~~

## 配置局域网代理功能 

> 为什么要配置局域网代理功能？
>
> 原因是如果我们局域网中有多台主机都想要科学上网，比如我们的宿 主机和我们的Kali都想要进行科学上网，我们配置2个客户端就非常的麻烦，我们允许局域网中其他主机 可以使用我们的代理 

![](http://junmoxiao.org.cn/20200206162437.png)



![](http://junmoxiao.org.cn/20200206163138.png)

## 配置tor浏览器并进入暗网 

>下载地址：https://www.torproject.org/download/

![](http://junmoxiao.org.cn/20200206163343.png)

## 更换国外VPS机房提升科学上网速度

>如果在科学上网的过程中，感觉网速不是很理想，可以尝试更换下VPS的机房。 购买完VPS，默认所在的机房是：US: Los Angeles, California (DC2 QNET) [USCA_2] 我们也可以更换机房，更换机房后，VPS的IP地址会变更，其他设置和安装的SSR不会受影响

![](http://junmoxiao.org.cn/20200206164106.png)