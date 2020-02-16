---
title: "Kali主动信息收集"
date: 2020-02-08T19:06:52+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---

主动信息收集

<!--more-->



## 主动信息收集

>*  直接与目标系统交互通信
>
>* 无法避免留下访问痕迹
>* 使用受控的第三方电脑进行探测，使用代理或已经被控制的机器
>* 扫描发送不同的探测，根据返回结果判断目标状态  scapy工具



## OSI七层模型

![](http://junmoxiao.org.cn/20200208191342.png)

## TCP/IP五层模型

![](http://junmoxiao.org.cn/20200208192108.png)

![](http://junmoxiao.org.cn/20200208192135.png)

![](http://junmoxiao.org.cn/20200208192207.png)



## 基于OSI模型进行扫描

* 二层扫描

  >优点:扫描速度快，可靠
  >
  >缺点:不可路由
  >
  >命令: arping ，netdiscover,scapy

* 三层扫描

  >优点:可路由，速度快
  >
  >缺点:速度比二层慢，经常被边界防火墙过滤
  >
  >命令:ping，fping,scapy

* 四层扫描

  >优点:可路由，可靠，不太可能被防火墙过滤，可以发现所有端口都被过滤的主机
  >
  >缺点:基于状态过滤的防火墙可能过滤扫描，全端口扫描速度慢
  >
  >命令:Hping3 ，nmap,nc,scapy



##  二层扫描探测

>* ARP协议主要负责将局域网中的 32为IP地址转换为对应的 48位物理地址，即网卡的 MAC地址
>
>* 使用 apring命令查看局域网中的IP 是否有冲突 
>
>*  arping只能对一个IP地址进行判断
>
>  ![](http://junmoxiao.org.cn/20200208223722.png)

~~~
root@kali-53:~# arping 192.168.1.55 -c 3
ARPING 192.168.1.55
60 bytes from 00:0c:29:19:10:65 (192.168.1.55): index=0 time=584.515 usec
60 bytes from 00:0c:29:19:10:65 (192.168.1.55): index=1 time=835.501 usec
60 bytes from 00:0c:29:19:10:65 (192.168.1.55): index=2 time=341.765 usec

--- 192.168.1.55 statistics ---
3 packets transmitted, 3 packets received,   0% unanswered (0 extra)
rtt min/avg/max/std-dev = 0.342/0.587/0.836/0.202 ms

~~~

>* Netdiscover是一个主动/被动的 ARP侦查工具。使用 Netdiscover工具可以在网络上扫描 IP地 址段，检查在线主机或搜索为它们发送的 ARP请求
>
>* 主动的探测发现网络内主机往往会引起网络管理员的注意 
>
>  -i device: your network device 
>
>  -r range: scan a given range instead of auto scan. 192.168.1.0/24,/16,/8

~~~
root@kali-53:~# netdiscover -i eth0 -r 192.168.1.0/24

Currently scanning: Finished!   |   Screen View: Unique Hosts                 
                                                                               
 16 Captured ARP Req/Rep packets, from 7 hosts.   Total size: 960              
 _____________________________________________________________________________
   IP            At MAC Address     Count     Len  MAC Vendor / Hostname      
 -----------------------------------------------------------------------------
 192.168.1.202   00:26:40:00:0a:0c      7     420  Baustem Broadband Technologi
 192.168.1.1     00:26:40:00:0a:0b      2     120  Baustem Broadband Technologi
 192.168.1.8     30:50:fd:9e:d4:c2      1      60  Unknown vendor              
 192.168.1.10    88:d7:f6:d8:3d:c0      1      60  ASUSTek COMPUTER INC.       
 192.168.1.55    00:0c:29:19:10:65      2     120  VMware, Inc.                
 192.168.1.6     48:2c:a0:45:83:d6      1      60  Xiaomi Communications Co Ltd
 192.168.1.9     e0:37:bf:ad:1a:e5      2     120  Wistron Neweb Corporation 
~~~

>* 被动模式的方法更加隐蔽，但是速度会比较慢，网卡被设置为混杂模式来侦听网络内的 arp数据包迚进行被动式探测，这种方式就需要网络内设备发送 arp包才能被探测到
>* -p passive mode: do not send anything, only sniff

~~~
root@kali-53:~# netdiscover -p

 Currently scanning: (passive)   |   Screen View: Unique Hosts                                
                                                                                              
 30 Captured ARP Req/Rep packets, from 4 hosts.   Total size: 1800                            
 _____________________________________________________________________________
   IP            At MAC Address     Count     Len  MAC Vendor / Hostname      
 -----------------------------------------------------------------------------
 192.168.1.202   00:26:40:00:0a:0c     23    1380  Baustem Broadband Technologies, Ltd.       
 192.168.1.10    88:d7:f6:d8:3d:c0      4     240  ASUSTek COMPUTER INC.                      
 192.168.1.55    00:0c:29:19:10:65      2     120  VMware, Inc.                               
 192.168.1.1     00:26:40:00:0a:0b      1      60  Baustem Broadband Technologies, Ltd.   
~~~

## 三层扫描探测

* ping 命令是我们常用的判断主机之间网络是否畅通，同样也是能判断我们的目标主机是否存活。

* traceroute探测追踪路由能知道中间经过了哪些网络设备 

  ![](http://junmoxiao.org.cn/20200208223622.png)

~~~
root@kali-53:~# ping 192.168.1.55 -c 3
PING 192.168.1.55 (192.168.1.55) 56(84) bytes of data.
64 bytes from 192.168.1.55: icmp_seq=1 ttl=128 time=1.07 ms
64 bytes from 192.168.1.55: icmp_seq=2 ttl=128 time=0.435 ms
64 bytes from 192.168.1.55: icmp_seq=3 ttl=128 time=0.553 ms

--- 192.168.1.55 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 12ms
rtt min/avg/max/mdev = 0.435/0.686/1.071/0.277 ms

~~~

~~~
root@kali-53:~# traceroute www.shadowfiend.cn
traceroute to www.shadowfiend.cn (185.199.110.153), 30 hops max, 60 byte packets
 1  _gateway (192.168.1.1)  2.743 ms  3.334 ms  4.046 ms
 2  10.225.128.1 (10.225.128.1)  21.678 ms  21.612 ms  21.541 ms
 3  172.19.3.9 (172.19.3.9)  21.489 ms  21.432 ms  21.386 ms
 4  172.19.21.41 (172.19.21.41)  21.321 ms * *
 5  * * *
 6  * * *
 7  * * *
 8  * * *
 9  * * *
10  * * *
11  * * *
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  * * *
25  * * *
26  * * *
27  * * *
28  * * *
29  * * *
30  * * *
~~~

>* fping就是 ping命令的加强版他可以对一个 IP段进行ping扫描
>* -g表示对地址段进行扫描如果不加可以对某个IP进行扫描 
>* -c 表示 ping的次数 
>* fping.txt 表示将扫描的结果重定向到 fping.txt ，原因是如果扫描一个网段的话输出结果是非常多的，我们输出重定向到文件中只会获得存活的主机信息

~~~
root@kali-53:~# fping -g 192.168.1.0/24 > /fping.txt -c 1
root@kali-53:~# cat /fping.txt 
192.168.1.1   : [0], 84 bytes, 2.49 ms (2.49 avg, 0% loss)
192.168.1.8   : [0], 84 bytes, 1.13 ms (1.13 avg, 0% loss)
192.168.1.9   : [0], 84 bytes, 5.23 ms (5.23 avg, 0% loss)
192.168.1.10  : [0], 84 bytes, 0.26 ms (0.26 avg, 0% loss)
192.168.1.6   : [0], 84 bytes, 220 ms (220 avg, 0% loss)
192.168.1.4   : [0], 84 bytes, 337 ms (337 avg, 0% loss)
192.168.1.53  : [0], 84 bytes, 0.07 ms (0.07 avg, 0% loss)
192.168.1.55  : [0], 84 bytes, 1.38 ms (1.38 avg, 0% loss)
192.168.1.202 : [0], 84 bytes, 0.94 ms (0.94 avg, 0% loss)

~~~

## 四层扫描探测

* Hping3是一个命令行下使用的 TCP/IP数据包组装/分析工具，通常web服务会用来做压力测试使 用，也可以进行 DOS攻击的实验

* Hping3只能每次扫描一个目标

* -c   发送的数据包的数量

  -d 发送到目标机器的每个数据包的大小。单位是字节 

  -S 只发送SYN数据包

   -w TCP窗口大小

   -p  目的地端口这里可以使用任何端口

  --flood 尽可能快地发送数据包，不需要考虑显示入站回复。洪水攻击模式。 

  --rand-source 使用随机性的源头IP地址。这里的伪造的IP地址，只是在局域中伪造。通过路由器后，还会还原成真实的 IP 地址 

~~~shell
root@kali-53:~# hping3 -c 10 -d 120 -S -w 120 --flood -p 80 --rand-source www.shadowfiend.cn
HPING www.shadowfiend.cn (eth0 185.199.108.153): S set, 40 headers + 120 data bytes
hping in flood mode, no replies will be shown
^C
--- www.shadowfiend.cn hping statistic ---
133847 packets transmitted, 0 packets received, 100% packet loss
round-trip min/avg/max = 0.0/0.0/0.0 ms
~~~

>* nmap是Network Mapper简写，最早是Linux下的网络扫描和嗅探工具包。 
>
>* nmap扫描类型主要有 TCP的全连接扫描（会在被扫描机器留下记录），半连接扫描（不会留下记录） 
>
>* -sn 表示只 ping扫描，不进行行端口扫描
>
>* -sS 表示使用SYN 进行半连接扫描，默认使用全连接扫描
>
>* -p 目的地端口这里可以使用任何端口
>
>  ![](http://junmoxiao.org.cn/20200208223328.png)
>
>  ![](http://junmoxiao.org.cn/20200208223543.png)

~~~
root@kali-53:~# nmap -sn 192.168.1.0/24
Starting Nmap 7.70 ( https://nmap.org ) at 2020-02-08 21:28 CST
Nmap scan report for 192.168.1.1
Host is up (0.00096s latency).
MAC Address: 00:26:40:00:0A:0B (Baustem Broadband Technologies)
Nmap scan report for 192.168.1.8
Host is up (0.00054s latency).
MAC Address: 30:50:FD:9E:D4:C2 (Unknown)
Nmap scan report for 192.168.1.9
Host is up (0.29s latency).
MAC Address: E0:37:BF:AD:1A:E5 (Wistron Neweb)
Nmap scan report for 192.168.1.10
Host is up (0.00011s latency).
MAC Address: 88:D7:F6:D8:3D:C0 (Asustek Computer)
Nmap scan report for 192.168.1.55
Host is up (0.00050s latency).
MAC Address: 00:0C:29:19:10:65 (VMware)
Nmap scan report for 192.168.1.202
Host is up (0.00067s latency).
MAC Address: 00:26:40:00:0A:0C (Baustem Broadband Technologies)
Nmap scan report for 192.168.1.53
Host is up.
Nmap done: 256 IP addresses (7 hosts up) scanned in 4.10 seconds

~~~

~~~
root@kali-53:~# nmap -sS 192.168.1.1/24 -p 80,443,22,21 > /nmap.txt
root@kali-53:~# cat /nmap.txt 
Starting Nmap 7.70 ( https://nmap.org ) at 2020-02-08 21:31 CST
Nmap scan report for 192.168.1.1
Host is up (0.0023s latency).

PORT    STATE  SERVICE
21/tcp  closed ftp
22/tcp  closed ssh
80/tcp  open   http
443/tcp closed https
MAC Address: 00:26:40:00:0A:0B (Baustem Broadband Technologies)

Nmap scan report for 192.168.1.4
Host is up (0.27s latency).

PORT    STATE  SERVICE
21/tcp  closed ftp
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 14:D1:1F:CD:08:ED (Huawei Technologies)

Nmap scan report for 192.168.1.8
Host is up (0.00055s latency).

PORT    STATE  SERVICE
21/tcp  closed ftp
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 30:50:FD:9E:D4:C2 (Unknown)

Nmap scan report for 192.168.1.9
Host is up (0.18s latency).

PORT    STATE  SERVICE
21/tcp  closed ftp
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: E0:37:BF:AD:1A:E5 (Wistron Neweb)

Nmap scan report for 192.168.1.10
Host is up (0.00010s latency).

PORT    STATE    SERVICE
21/tcp  filtered ftp
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp open     https
MAC Address: 88:D7:F6:D8:3D:C0 (Asustek Computer)

Nmap scan report for 192.168.1.55
Host is up (0.00055s latency).

PORT    STATE  SERVICE
21/tcp  closed ftp
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 00:0C:29:19:10:65 (VMware)

Nmap scan report for 192.168.1.202
Host is up (0.00055s latency).

PORT    STATE  SERVICE
21/tcp  closed ftp
22/tcp  closed ssh
80/tcp  open   http
443/tcp closed https
MAC Address: 00:26:40:00:0A:0C (Baustem Broadband Technologies)

Nmap scan report for 192.168.1.53
Host is up (0.000034s latency).

PORT    STATE  SERVICE
21/tcp  closed ftp
22/tcp  open   ssh
80/tcp  closed http
443/tcp closed https

Nmap done: 256 IP addresses (8 hosts up) scanned in 7.40 seconds

~~~

~~~
root@kali-53:~# nmap 192.168.1.1/24 -p 80,443,22,21 > /nmap.txt
~~~

>* nc是 netcat 的简写，有着网络界的瑞士军刀美誉。因为它短小精悍、功能实用，被设计为一个简单、 可靠的网络工具 
>
>* 实现任意 TCP/UDP端口的侦听，nc 可以作为 server以TCP或UDP方式侦听指定端口 
>
>* 端口的扫描，nc 可以作为client发起 TCP或UDP连接
>
>* 机器之间传输文件
>
>*  硬盘克隆
>
>* -nv 我们扫描的目标是个IP地址不做域名解析 
>
>  -w 超时时间 
>
>  -z 进行端口扫描 

~~~
root@kali-53:~# nc -nv 192.168.1.1 -w 1 -z 1-1024
(UNKNOWN) [192.168.1.1] 650 (?) open
(UNKNOWN) [192.168.1.1] 80 (http) open
(UNKNOWN) [192.168.1.1] 53 (domain) open
~~~

>* scapy是一个可以让用户发送、侦听和解析并伪装网络报文的 Python 程序。这些功能可以用于制作 侦测、扫描和攻击网络的工具。
>* scapy定制 ARP协议发送arp数据包
>* sr1()函数接收和发送的数据包

~~~
root@kali-53:~# scapy
WARNING: No route found for IPv6 destination :: (no default route?)
WARNING: IPython not available. Using standard Python shell instead.
AutoCompletion, History are disabled.
                                      
                     aSPY//YASa       
             apyyyyCY//////////YCa       |
            sY//////YSpcs  scpCY//Pp     | Welcome to Scapy
 ayp ayyyyyyySCP//Pp           syY//C    | Version 2.4.0
 AYAsAYYYYYYYY///Ps              cY//S   |
         pCCCCY//p          cSSps y//Y   | https://github.com/secdev/scapy
         SPPPP///a          pP///AC//Y   |
              A//A            cyP////C   | Have fun!
              p///Ac            sC///a   |
              P////YCpc           A//A   | Craft packets before they craft
       scccccp///pSP///p          p//Y   | you.
      sY/////////y  caa           S//P   |                      -- Socrate
       cayCyayP//Ya              pY/Ya   |
        sY/PsY////YCc          aC//Yp 
         sc  sccaCY//PCypaapyCP//YSs  
                  spCPY//////YPSps    
                       ccaacs
~~~

~~~
>>> ARP().display()
###[ ARP ]### 
   hwtype= 0x1  硬件类型   
   ptype= 0x800 协议类型   
   hwlen= 6  硬件地址长度（MAC）   
   plen= 4   协议地址长度（IP）   
   op= who-has who-has查询   
   hwsrc= 00:0c:29:6a:cf:1d 源MAC地址   
   psrc= 192.168.1.53  源IP地址   
   hwdst= 00:00:00:00:00:00    
   pdst= 0.0.0.0   向谁发送查询请求 
~~~

~~~
>>> sr1(ARP(psrc="192.168.1.53",pdst="192.168.1.63"))
Begin emission:
.*Finished sending 1 packets.

Received 2 packets, got 1 answers, remaining 0 packets
<ARP  hwtype=0x1 ptype=0x800 hwlen=6 plen=4 op=is-at hwsrc=00:0c:29:2a:85:a8 psrc=192.168.1.63 hwdst=00:0c:29:7a:bf:3c pdst=192.168.1.53 |<Padding  load='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00' |>>
发现源地址 psrc=192.168.1.63,说明已经收到192.168.1.63的应答包
~~~

>* scapy定制ping数据包  IP()生成 ping包的源IP和目标IP ，ICMP() 生 ping包的类型。使用 IP()和ICMP()两个函数 ，可以生成 ping包，进行探测

~~~
>>> IP().display()
###[ IP ]### 
version= 4 版本:4,即IPv4 
ihl= None 首部长度 
tos= 0x0 服务 
len= None 总长度 
id= 1 标识 
flags= frag= 0 标志 
ttl= 64 生存时间 
proto= hopopt 传输控制协议 
IPv6逐跳选项 
chksum= None 首部校验和 
src= 127.0.0.1 源地址 
dst= 127.0.0.1 目的地址

~~~

~~~
>>> ICMP().display()
###[ ICMP ]### 
type= echo-request 类型标识ICMP报文的类型 
code= 0 代码 
chksum= None 校验和
id= 0x0 标识 
seq= 0x0 序列符

~~~

~~~
>>> sr=sr1(IP(src="192.168.1.53",dst="192.168.1.63")/ICMP(),timeout=1)
Begin emission:
....Finished sending 1 packets.
*
Received 5 packets, got 1 answers, remaining 0 packets
>>> sr.display()
###[ IP ]### 
  version= 4
  ihl= 5
  tos= 0x0
  len= 28
  id= 52258
  flags= 
  frag= 0
  ttl= 64
  proto= icmp
  chksum= 0x2afa
  src= 192.168.1.63
  dst= 192.168.1.53
  \options\
###[ ICMP ]### 
     type= echo-reply
     code= 0
     chksum= 0xffff
     id= 0x0
     seq= 0x0
###[ Padding ]### 
        load= '\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
~~~

>* scapy定制 TCP协议发送 SYN 数据包 

~~~
>>> TCP().display()
###[ TCP ]### 
sport= ftp_data TCP源端口 
dport= http TCP目的端口 
seq= 0 32 位序号 
ack= 0 32位确认序号 
dataofs= None 4位首部长度 
reserved= 0 保留6位 
flags=S 标志域，紧急标志、有意义的应答标志、推、重置连接标志、同步序列号标志、 完成发送数据标志。按照顺序排列是：URG、ACK、PSH、RST、SYN、FIN 
window= 8192 窗口大小 
chksum= None 16 位校验和 
urgptr= 0 优先指针 o
ptions= [] 选项
~~~

~~~
root@kali-53:~# nmap -sS 192.168.1.63 -p 80,22,443
Starting Nmap 7.70 ( https://nmap.org ) at 2020-02-08 22:25 CST
Nmap scan report for 192.168.1.63
Host is up (0.00052s latency).

PORT    STATE    SERVICE
22/tcp  open     ssh
80/tcp  closed   http
443/tcp filtered https
MAC Address: 00:0C:29:2A:85:A8 (VMware)

Nmap done: 1 IP address (1 host up) scanned in 0.51 seconds


>>> it=sr1(IP(dst="192.168.1.63")/TCP(flags="S",dport=22),timeout=1)
Begin emission:
.Finished sending 1 packets.
*
Received 2 packets, got 1 answers, remaining 0 packets
>>> it.display()
###[ IP ]### 
  version= 4
  ihl= 5
  tos= 0x0
  len= 44
  id= 0
  flags= DF
  frag= 0
  ttl= 64
  proto= tcp
  chksum= 0xb707
  src= 192.168.1.63
  dst= 192.168.1.53
  \options\
###[ TCP ]### 
     sport= ssh
     dport= ftp_data
     seq= 4138053164
     ack= 1
     dataofs= 6
     reserved= 0
     flags= SA
     window= 29200
     chksum= 0xfd43
     urgptr= 0
     options= [('MSS', 1460)]
###[ Padding ]### 
        load= '\x00\x00'
 flags=SA的数据包。SA 标志即 SYN+ACK。我们收到服务器tcp三次插手中的第二 个包，能收到回应，表示端口开放。基于tcp的半连接扫描，更隐密，更丌容易被发现
~~~

##  僵尸扫描

>* 僵尸主机：僵尸主机是指感染僵尸程序病毒，从而被黑客程序控制的计算机设备。但是僵尸扫描中的 僵尸主机指得是一个闲置的操作系统（这里的闲置是指主机不会主动和任何人通信），且此系统中IP数据 包中ID是递增的。比如：XP系统。现在win7，win10是不行的。故准备一台kali服务器(黑客主机)，centos服务器(目标主机)，winxp服务器(僵尸主机)
>
>* IPID：指的是通信过中，IP 数据包中的 ID
>
>* 僵尸扫描目的是说明目标主机端口是开放的(可以用nmap -sS 192.168.63 -p 80命令代替)
>
>  ![](http://junmoxiao.org.cn/20200208230108.png)

![](http://junmoxiao.org.cn/20200208224339.png)

![](http://junmoxiao.org.cn/20200208224417.png)

* 测试192.168.1.63目标主机22端口开放

~~~
>>> it1=sr1(IP(dst="192.168.1.54")/TCP(dport=445,flags="SA"),timeout=1)
Begin emission:
...Finished sending 1 packets.
*
Received 4 packets, got 1 answers, remaining 0 packets

~~~

~~~
>>> sr=sr1(IP(src="192.168.1.54",dst="192.168.1.63")/TCP(flags="S",dport=22))
Begin emission:
.....Finished sending 1 packets.
...*

~~~

~~~
>>> it2=sr1(IP(dst="192.168.1.54")/TCP(dport=445,flags="SA"),timeout=1)
Begin emission:
..Finished sending 1 packets.
.*
Received 4 packets, got 1 answers, remaining 0 packets

~~~

~~~
>>> it1.display()
###[ IP ]### 
  version= 4
  ihl= 5
  tos= 0x0
  len= 40
  id= 179
  flags= 
  frag= 0
  ttl= 128
  proto= tcp
  chksum= 0xb661
  src= 192.168.1.54
  dst= 192.168.1.53
  \options\
###[ TCP ]### 
     sport= microsoft_ds
     dport= ftp_data
     seq= 0
     ack= 0
     dataofs= 5
     reserved= 0
     flags= R
     window= 0
     chksum= 0x2a54
     urgptr= 0
     options= []
###[ Padding ]### 
        load= '\x00\x00\x00\x00\x00\x00'

~~~

~~~
>>> it2.display()
###[ IP ]### 
  version= 4
  ihl= 5
  tos= 0x0
  len= 40
  id= 181
  flags= 
  frag= 0
  ttl= 128
  proto= tcp
  chksum= 0xb65f
  src= 192.168.1.54
  dst= 192.168.1.53
  \options\
###[ TCP ]### 
     sport= microsoft_ds
     dport= ftp_data
     seq= 0
     ack= 0
     dataofs= 5
     reserved= 0
     flags= R
     window= 0
     chksum= 0x2a54
     urgptr= 0
     options= []
###[ Padding ]### 
        load= '\x00\x00\x00\x00\x00\x00'
>>> exit();
~~~

* 总结 ：第一次返回的R标志数据包释放的IPID=179,第二次返回R标志数据包释放的IPID=181。说明目标主机端口22是开放的

## 使用nmap进行僵尸扫描 

>* 目的:扫描网段中某些机器可以作为僵尸主机 
>* -p #指定扫描的端口，只扫描常用端口就可以。
>* --script=ipidseq.nse #判断主机是否可以当做僵尸主机 
>* -sI  可以指定僵尸主机进行扫描目标主机(隐藏主机)。注意是大写的I 

~~~
root@kali-53:~# nmap -sS 192.168.1.0/24 -p 1-1024 --script=ipidseq.nse
Starting Nmap 7.70 ( https://nmap.org ) at 2020-02-08 23:06 CST
Nmap scan report for 192.168.1.1
Host is up (0.010s latency).
Not shown: 1021 closed ports
PORT    STATE SERVICE
53/tcp  open  domain
80/tcp  open  http
650/tcp open  obex
MAC Address: 00:26:40:00:0A:0B (Baustem Broadband Technologies)

Host script results:
|_ipidseq: All zeros

Nmap scan report for 192.168.1.4
Host is up (0.0072s latency).
All 1024 scanned ports on 192.168.1.4 are closed
MAC Address: 14:D1:1F:CD:08:ED (Huawei Technologies)

Host script results:
|_ipidseq: Incremental!

Nmap scan report for 192.168.1.6
Host is up (0.0078s latency).
All 1024 scanned ports on 192.168.1.6 are closed
MAC Address: 48:2C:A0:45:83:D6 (Unknown)

Host script results:
|_ipidseq: Incremental!

Nmap scan report for 192.168.1.8
Host is up (0.0018s latency).
All 1024 scanned ports on 192.168.1.8 are closed
MAC Address: 30:50:FD:9E:D4:C2 (Unknown)

Host script results:
|_ipidseq: Incremental!

Nmap scan report for 192.168.1.10
Host is up (0.00032s latency).
Not shown: 1018 filtered ports
PORT    STATE SERVICE
135/tcp open  msrpc
139/tcp open  netbios-ssn
443/tcp open  https
445/tcp open  microsoft-ds
902/tcp open  iss-realsecure
912/tcp open  apex-mesh
MAC Address: 88:D7:F6:D8:3D:C0 (Asustek Computer)

Host script results:
|_ipidseq: Incremental!

Nmap scan report for 192.168.1.54
Host is up (0.00016s latency).
Not shown: 1021 closed ports
PORT    STATE SERVICE
135/tcp open  msrpc
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds
MAC Address: 00:0C:29:0B:49:95 (VMware)

Host script results:
|_ipidseq: Incremental!

Nmap scan report for 192.168.1.63
Host is up (0.00057s latency).
Not shown: 1022 filtered ports
PORT   STATE  SERVICE
22/tcp open   ssh
80/tcp closed http
MAC Address: 00:0C:29:2A:85:A8 (VMware)

Host script results:
|_ipidseq: All zeros

Nmap scan report for 192.168.1.202
Host is up (0.00070s latency).
Not shown: 1021 closed ports
PORT    STATE SERVICE
23/tcp  open  telnet
80/tcp  open  http
111/tcp open  rpcbind
MAC Address: 00:26:40:00:0A:0C (Baustem Broadband Technologies)

Host script results:
|_ipidseq: All zeros

Nmap scan report for 192.168.1.53
Host is up (0.0000060s latency).
Not shown: 1023 closed ports
PORT   STATE SERVICE
22/tcp open  ssh

Host script results:
|_ipidseq: All zeros

Nmap done: 256 IP addresses (9 hosts up) scanned in 19.52 seconds

Incremental  英 [ˌɪnkrɪˈmɛnt(ə)l]   增量式;增量备仹;增量的;渐迚的;增量法 表示主机IPID为递增，可以做为僵尸主机
~~~

~~~
 root@kali-53:~# netdiscover -i eth0 -r 192.168.1.0/24

 
 Currently scanning: Finished!   |   Screen View: Unique Hosts                                
                                                                                              
 28 Captured ARP Req/Rep packets, from 7 hosts.   Total size: 1680                            
 _____________________________________________________________________________
   IP            At MAC Address     Count     Len  MAC Vendor / Hostname      
 -----------------------------------------------------------------------------
 192.168.1.1     00:26:40:00:0a:0b      3     180  Baustem Broadband Technologies, Ltd.       
 192.168.1.202   00:26:40:00:0a:0c     15     900  Baustem Broadband Technologies, Ltd.       
 192.168.1.8     30:50:fd:9e:d4:c2      1      60  Unknown vendor                             
 192.168.1.10    88:d7:f6:d8:3d:c0      3     180  ASUSTek COMPUTER INC.                      
 192.168.1.54    00:0c:29:0b:49:95      2     120  VMware, Inc.                               
 192.168.1.63    00:0c:29:2a:85:a8      3     180  VMware, Inc.                               
 192.168.1.6     48:2c:a0:45:83:d6      1      60  Xiaomi Communications Co Ltd 
 
 xp,win10,centos7,,xiaomi可以作为僵尸机。
~~~

~~~
root@kali-53:~# nmap 192.168.1.63 -sI 192.168.1.54 -p 1-1024 
WARNING: Many people use -Pn w/Idlescan to prevent pings from their true IP.  On the other hand, timing info Nmap gains from pings can allow for faster, more reliable scans.
Starting Nmap 7.70 ( https://nmap.org ) at 2020-02-08 23:16 CST
Idle scan using zombie 192.168.1.54 (192.168.1.54:443); Class: Incremental
Nmap scan report for 192.168.1.63
Host is up (0.029s latency).
Not shown: 1023 closed|filtered ports
PORT   STATE SERVICE
22/tcp open  ssh
MAC Address: 00:0C:29:2A:85:A8 (VMware)

Nmap done: 1 IP address (1 host up) scanned in 8.61 seconds

~~~

