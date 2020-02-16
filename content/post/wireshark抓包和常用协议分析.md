---
title: "Wireshark抓包和常用协议分析"
date: 2020-02-13T23:23:56+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---



Wireshark抓包分析不同协议的数据包



<!--more-->

## WireShark简介 



* Wireshark是一个网络封包分析软件。网络封包分析软件的功能是撷取网络封包，并尽可能显示出最 为详细的网络封包资料。Wireshark使用 WinPCAP作为接口，直接与网卡进行数据报文交换。

  

  ## WireShark 快速分析数据包技巧 

  * 选择捕获接口。一般都是选择违接到Internet网络的接口，这样才可以捕获到不网络相关的 数据。否则，捕获到的其它数据对自己也没有任何帮劣。 

    ![](http://junmoxiao.org.cn/20200212161226.png)

* 确定Wireshark的物理位置。如果没有一个正确的位置，启动Wireshark后会花费很长的时间捕 获一些不自己无关的数据。 

  >混杂模式概述：混杂模式就是接收所有经过网卡的数据包，包括不是发给本机的包，即不验证MAC 地址。普通模式下网卡只接收发给本机的包（包括广播包）传逑给上层程序，其它的包一律丢弃。 一般来说，混杂模式不会影响网卡的正常工作，多在网络监听工具上使用。 

  ![](http://junmoxiao.org.cn/20200212140912.png)

* 使用捕获过滤器。通过设置捕获过滤器，可以避免产生过大的捕获数据。这样用户在分析数据 时，也不会受其它数据干扰。而且，还可以为用户节约大量的时间。 

  >**协议** **方向** **类型** **数据**
  >
  >- 协议，可能的值：ether、ip、arp、tcp、udp、dns、http、ftp……，如果没有特别指明是什么协议，则默认使用所有支持的协议。
  >- 方向，可能的值：src、dst，如果没有特别指明来源或目的地，则默认使用“src or dst”作为关键字。例如，“host 192.168.1.10”与“src or dst host 192.168.1.10”是一样的。
  >- 类型，可能的值：net、port、host，如果没有指定此值，则默认使用”host”关键字。例如，“src 192.168.1.10”与“src host 192.168.1.10”相同。
  >- 逻辑与&&，逻辑或||，逻辑非!  **src 192.168.1.10 && port 80**

  ![](http://junmoxiao.org.cn/20200212161121.png)

* 使用显示过滤器。通常使用捕获过滤器过滤后的数据，往往还是很复杂。为了使过滤的数据包 再更细致，此时使用显示过滤器进行过滤。 

  ![](http://junmoxiao.org.cn/20200212161739.png)

* 使用着色规制。通常使用显示过滤器过滤后的数据，都是有用的数据包。如果想更加突出的显示某个会话，可以使用着色规则高亮显示。 

![](http://junmoxiao.org.cn/20200212161940.png)

*  构建图表。如果用户想要更明显的看出一个网络中数据的变化情况，使用图表的形式可以很方 便的展现数据分布情况。 

![](http://junmoxiao.org.cn/20200212162113.png)

![](http://junmoxiao.org.cn/20200212162158.png)

*  重组数据。当传输较大的图片或文件时，需要将信息分布在多个数据包中。这时候就需要使用 重组数据的方法来抓取完整的数据。Wireshark的重组功能，可以重组一个会话中不同数据包的信息，或 者是重组一个完整的图片和文件。



## 常见协议包 

* 使用显示过滤器筛选arp的数据包 

  >地址解析协议（Address Resolution Protocol，缩写：ARP）是一个通过解析网络层地址来 找寻数据链路层地址的网络传输协议，它在IPv4中极其重要。ARP是通过网络地址来定位MAC地址。 
  >
  >192.168.1.53 广播：谁有192.168.1.10 的MAC地址？ 
  >
  >192.168.1.10 应答：192.168.1.10 的MAC地址是 xxxxxxxxxxx 

~~~
root@kali-53:~# nmap -sn 192.168.1.10
Starting Nmap 7.70 ( https://nmap.org ) at 2020-02-12 17:35 CST
Nmap scan report for 192.168.1.10
Host is up (0.00014s latency).
MAC Address: 88:D7:F6:D8:3D:C0 (Asustek Computer)
Nmap done: 1 IP address (1 host up) scanned in 0.14 seconds

~~~

~~~
root@kali-53:~# arping 192.168.1.10 -c 1
ARPING 192.168.1.10
60 bytes from 88:d7:f6:d8:3d:c0 (192.168.1.10): index=0 time=114.380 usec

--- 192.168.1.10 statistics ---
1 packets transmitted, 1 packets received,   0% unanswered (0 extra)
rtt min/avg/max/std-dev = 0.114/0.114/0.114/0.000 ms

~~~

![](http://junmoxiao.org.cn/20200212173508.png)

* 分析arp请求包(三层)

  ![](http://junmoxiao.org.cn/20200212173809.png)

>第一层:物理层
>
>![](http://junmoxiao.org.cn/20200212174653.png)

>第二层:数据链路层
>
>![](http://junmoxiao.org.cn/20200212174912.png)

>第三层:ARP地址解析协议层
>
>![](http://junmoxiao.org.cn/20200212175205.png)

* 分析arp响应包(三层)

  >第一层:物理层
  >
  >![](http://junmoxiao.org.cn/20200212175408.png)

>第二层:数据链路层
>
>![](http://junmoxiao.org.cn/20200212175655.png)

>第三层:ARP地址解析协议层
>
>![](http://junmoxiao.org.cn/20200212182302.png)



* 使用显示过滤器筛选icmp的数据包 

  >本机发送一个ICMP Echo Request的包 
  >
  >接受方返回一个ICMP Echo Reply，包含了接受到数据拷贝和一些其他指令 

  ~~~
  C:\Users\Administrator>ping 192.168.1.1
  
  正在 Ping 192.168.1.1 具有 32 字节的数据:
  来自 192.168.1.1 的回复: 字节=32 时间=2ms TTL=64
  来自 192.168.1.1 的回复: 字节=32 时间=2ms TTL=64
  来自 192.168.1.1 的回复: 字节=32 时间=2ms TTL=64
  来自 192.168.1.1 的回复: 字节=32 时间=1ms TTL=64
  
  192.168.1.1 的 Ping 统计信息:
      数据包: 已发送 = 4，已接收 = 4，丢失 = 0 (0% 丢失)，
  往返行程的估计时间(以毫秒为单位):
      最短 = 1ms，最长 = 2ms，平均 = 1ms
  ~~~

  ![](http://junmoxiao.org.cn/20200212182611.png)

* 分析ping请求包(四层)

![](http://junmoxiao.org.cn/20200212182746.png)

>第三层:网络层
>
>![](http://junmoxiao.org.cn/20200212183250.png)
>
>![](http://junmoxiao.org.cn/20200212183748.png)

>第四层:ICMP层
>
>![](http://junmoxiao.org.cn/20200212184026.png)
>
>

* 分析ping响应包(四层)

>第四层:ICMP层
>
>![](http://junmoxiao.org.cn/20200212184508.png)

* 使用显示过滤器筛选tcp的数据包 

>* 3次握手
>
>* Xshell进程连接 Kali Linux就会捕获到完整的TCP3次握手的连接。 

![](http://junmoxiao.org.cn/20200213213525.png)

![](http://junmoxiao.org.cn/20200213213641.png)

* 分析TCP请求包 （四层）第一次握手

![](http://junmoxiao.org.cn/20200213213816.png)

* 分析TCP请求包(四层)第二次握手

![](http://junmoxiao.org.cn/20200213213932.png)

* 分析TCP请求包(四层)第三次握手

![](http://junmoxiao.org.cn/20200213214313.png)

* 图表分析

![](http://junmoxiao.org.cn/20200213214800.png)

>* 四次挥手
>
>* Xshell窗口中输入 exit退出 

![](http://junmoxiao.org.cn/20200213215210.png)

>* 我们在终端输入EXIT 实际上是在我们Kali上执行的命令，表示我们SSHD的 Server端向客户端发起关闭连接请求
>* 第一次挥手：服务端发送一个[FIN+ACK]，表示自己没有数据要发送了，想断开连接，并进入 FIN_WAIT_1状态 
>* 第二次挥手：客户端收到FIN后，知道丌会再有数据从服务端传来，发送ACK进行确认，确认序号 为收到序号+1（不SYN相同，一个FIN占用一个序号），客户端进入CLOSE_WAIT状态
>* 第三次挥手：客户端发送FIN给对方，表示自己没有数据要发送了，客户端进入LAST_ACK状态， 然后直接断开TCP会话的连接，释放相应的资源。 
>* 第四次挥手：服务户端收到了客户端的FIN信令后，进入TIMED_WAIT状态，并发送ACK确认消 息。服务端在TIMED_WAIT状态下，等待一段时间，没有数据到来，就认为对面已经收到了自己发送的 ACK并正确关闭了迚入CLOSE状态，自己也断开了TCP违接，释放所有资源。当客户端收到服务端的 ACK回应后，会进入CLOSE状态并关闭本端的会话接口，释放相应资源。 

* 使用显示过滤器筛选http的数据包 

>筛选TCP协议因为HTTP是 TCP 的上层协议，所以我们过滤TCP的数据会包含HTTP协议的数据包 

~~~
root@kali-53:~# curl -I baidu.com
HTTP/1.1 200 OK
Date: Thu, 13 Feb 2020 14:01:28 GMT
Server: Apache
Last-Modified: Tue, 12 Jan 2010 13:48:00 GMT
ETag: "51-47cf7e6ee8400"
Accept-Ranges: bytes
Content-Length: 81
Cache-Control: max-age=86400
Expires: Fri, 14 Feb 2020 14:01:28 GMT
Connection: Keep-Alive
Content-Type: text/html

~~~

* 与服务器建立连接

  >* TCP的3次握手
  >
  >* 客户端向服务器发送了一个HTTP的HEAD请求
  >* 服务器收到我们的请求返回了一个SEQ/ACK进行确认 
  >* 服务器将HTTP的头部信息返回给我们客户端 状态码为200 表示页面正常 
  >* 客户端收到服务器返回的头部信息向服务器发送SEQ/ACK进行确认

![](http://junmoxiao.org.cn/20200213220316.png)

* 与服务器断开连接

  >* TCP的4次挥手 

![](http://junmoxiao.org.cn/20200213220353.png)

![](http://junmoxiao.org.cn/20200213221025.png)

![](http://junmoxiao.org.cn/20200213221115.png)

* 使用显示过滤器筛选UDP-DNS协议的数据包 

  >* 前面分析HTTP协议向百度发送一个请求，这里我们 已经完成DNS解析的过程 
  >* dns协议是基于udp协议之上
  >* DNS数据包 一个5层的协议包它的4层协议是UDP

![](http://junmoxiao.org.cn/20200213221545.png)

* 分析DNS请求数据包

![](http://junmoxiao.org.cn/20200213222346.png)

* 分析DNS响应数据包

![](http://junmoxiao.org.cn/20200213222605.png)

## WireShark 抓包高级分析应用

>专家信息:整个网络中的TCP信息，都会被Wireshark的专家信息所记录，如丢包或者网络阻塞等。针对于每个协议的解析器，都会有一些专家信息，专家分析的功能可以将在网络上传输的一些不正常的流量标记出来用来分析数据包的异常和产生的错误,我们在分析的时候，可以通过专家信息窗口来查看使用该协议的数据包中一些特定状态的错误、警告以及提示等信息从而快速诊断出在这网络上出现的异常以及对非法流量的快速定位

- Error：数据包里面或者解析器解析时出现的错误
- Warnings：不正常通信中的异常数据包
- Notes：正常通信中的异常数据包
- Chats：网络通信的基本信息
- Details：显示数据包的详细信息
- Packet Comments：数据包的描述信息

![](http://junmoxiao.org.cn/20200213223128.png)

>统计出所有协议请求所占的比重

![](http://junmoxiao.org.cn/20200213223350.png)

>分组长度来查看协议长度的比重情况确定请求数据包和传输数据包次数

* 40-79字节的传输是一段控制字节传输，用来控制TCP/IP协议类似协议建立连接会话

* 1280-2559字节的传输是数据包的传输

![](http://junmoxiao.org.cn/20200213223732.png)

>TCP Stream流追踪和HTTP Stream流追踪(UDP等)，可以将这次通信所传输的http和tcp请求分块重新组合成一个易于我们看懂的形式展现，在分析流量内容也是极为重要的一个功能，不同的传输追踪下来的内容也不同，每一段被分组的都能被重组，我们只需要找到我们想要了解行为的数据包将其追踪就可以了

>会话

>端点



## WireShark 抓包解决服务器被黑上不了网

>* 场景：服务器被黑上不了网，可以ping通网关，但是不能上网
>* TTL ： 数据报的生存周期
>* 默认linux操作系统值：64，每经过一个路器节点，TTL值减1。TTL值为0时，说明目标地址不可 达并返回：Time to live exceeded  
>* TTL作用： 防止数据包无限制在公网中转发

~~~
root@kali-53:~# echo "1" >> /proc/sys/net/ipv4/ip_default_ttl 
root@kali-53:~# cat /proc/sys/net/ipv4/ip_default_ttl | more
1
~~~

* ping 网关192.168.1.1

  ~~~
  root@kali-53:~# ping 192.168.1.1 -c 1
  PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
  64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=4.00 ms
  
  --- 192.168.1.1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 4.002/4.002/4.002/0.000 ms
  
  ~~~

* ping 谷歌域名解析服务器

~~~
root@kali-53:~# ping 8.8.8.8 -c 1
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
From 192.168.1.1 icmp_seq=1 Time to live exceeded

--- 8.8.8.8 ping statistics ---
1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms

~~~

~~~
root@kali-53:~#  echo "64" > /proc/sys/net/ipv4/ip_default_ttl 
~~~

~~~
root@kali-53:~# ping 8.8.8.8 -c 3
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=42 time=58.8 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=43 time=60.7 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=43 time=51.4 ms

--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 6ms
rtt min/avg/max/mdev = 51.409/56.977/60.744/4.027 ms

目标返回给我们的TTL值为42，这表示我们的TTL值需要大于64-42=22 才可以访问8.8.8.8 
~~~

* MTR可以检测我们到达目标网络之间的所有网络设备的网络质量

~~~
apt install -y mtr 
mtr 8.8.8.8
~~~

![](http://junmoxiao.org.cn/20200213225639.png)