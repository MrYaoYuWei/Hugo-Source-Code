---
title: "Dnmap分布式执行大量扫描"
date: 2020-02-21T15:12:43+08:00
categories: ['Kali']
tags: ['安全渗透']
---

dnmap分布式扫描

<!--more-->

##  DNMAP集群简介 

>dnmap是一个用python写的进行分布式扫描的 nmap扫描框架，我们可以用dnmap来通过多个 台机器发起一个大规模的扫描，dnmap采用C/S 结构，执行大量扫描任务时非常便捷，扫描结果可以统 一管理
>
>用户在服务器端设定好nmap执行的命令，dnmap会自劢的分配给客户端进行扫描，并将扫描结果 提交给服务器
>
>dnmap有两个可执行文件，分别是dnmap_client何dnmap_server。在进行一个分布式namp 扫描之前，我们可以用dnmap_server来生成一个 dnmap的服务端，然后在其他机器用dnmap_client 进行连接

![](http://junmoxiao.org.cn/20200221151542.png)

* 生成证书文件

  > dnmap自带的用于TLS违接的pem文件证书太过久远，必须要重新生成一个pem证书客户 端和服务器才能正常连接

~~~
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out server.pem
cat key.pem >> server.pem 
~~~

* 创建NMAP命令文件 

  ~~~
  vim nmap.txt
  ~~~

* 使用dnmap_server启劢dnmap的服务端  

  > -f 跟一个待会要执行的nmap命令的文件 
  >
  > -P 跟一个用于TLS连接的pem文件，默认是使用随服务器提供的server.pem 

~~~
  ./dnmap_server.py -f nmap.txt  -P server.pem 
  apt install python-twisted-bin python-twisted-core
  ./dnmap_server.py -f nmap.txt  -P server.pem
~~~

* 使用dnmap_client启动dnmap的多个客户端 

  >-s 输入dnmap的服务器地址
  >
  >-p dnmap服务的端口号，默认是46001 

~~~
./dnmap_client.py -s 192.168.1.130
~~~

* 服务器端目录查看执行结果 

~~~
cd nmap_results/ 
~~~

