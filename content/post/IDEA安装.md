---
title: "IDEA安装"
date: 2020-01-05T19:55:13+08:00
author: 姚先生
categories: ['Java']

---

how to install IDEA environment



<!--more-->



## 下载IDEA软件（2018.1.8）

## 安装IDEA软件

## 破解IDEA软件

* 切换到安装IDEA的bin目录

* 将资源文件夹中的 JetbrainsCrack-3.1-release-enc.jar 复制到bin目录下

* 查看计算机的位数

* 64位修改IDEA的bin目录下的idea64.exe.vmoptions，32位修改IDEA的bin目录下的idea.exe.vmoptions

  ![](http://junmoxiao.org.cn/idea_01.png)

* 在idea64.exe.vmoptions最后一行加入 -javaagent:C:\Program Files\JetBrains\IntelliJ IDEA 2018.1.8\bin\JetbrainsCrack-3.1-release-enc.jar

  ![](http://junmoxiao.org.cn/idea_05.png)

* C:\Program Files\JetBrains\IntelliJ IDEA 2018.1.8\bin\ 是IDEA的bin目录

* 运行IntelliJ IDEA

* 注册码破解

~~~
ThisCrackLicenseId-{ 
“licenseId”:”ThisCrackLicenseId”, 
“licenseeName”:”idea”, 
“assigneeName”:”“, 
“assigneeEmail”:”idea@163.com”, 
“licenseRestriction”:”For This Crack, Only Test! Please support genuine!!!”, 
“checkConcurrentUse”:false, 
“products”:[ 
{“code”:”II”,”paidUpTo”:”2099-12-31”}, 
{“code”:”DM”,”paidUpTo”:”2099-12-31”}, 
{“code”:”AC”,”paidUpTo”:”2099-12-31”}, 
{“code”:”RS0”,”paidUpTo”:”2099-12-31”}, 
{“code”:”WS”,”paidUpTo”:”2099-12-31”}, 
{“code”:”DPN”,”paidUpTo”:”2099-12-31”}, 
{“code”:”RC”,”paidUpTo”:”2099-12-31”}, 
{“code”:”PS”,”paidUpTo”:”2099-12-31”}, 
{“code”:”DC”,”paidUpTo”:”2099-12-31”}, 
{“code”:”RM”,”paidUpTo”:”2099-12-31”}, 
{“code”:”CL”,”paidUpTo”:”2099-12-31”}, 
{“code”:”PC”,”paidUpTo”:”2099-12-31”} 
], 
“hash”:”2911276/0”, 
“gracePeriodDays”:7, 
"autoProlongated":false}
~~~

* 配置IDEA

* 自由选择项目

  ![](http://junmoxiao.org.cn/idea_00.png)

* 取消自动更新

  

![](http://junmoxiao.org.cn/idea_02.png)

* 自动导包和删除多余包

  ![](http://junmoxiao.org.cn/idea_03.png)

* 修改字体

  ![](http://junmoxiao.org.cn/idea_04.png)

* 提示API文档示例

  ![](http://junmoxiao.org.cn/idea_06.png)

## 配置maven项目（maven-3.6.0）

*  修改maven-3.6.0阿里源

  ![](http://junmoxiao.org.cn/idea_07.png)

* ctrl+f快速查找修改源

  ![](http://junmoxiao.org.cn/idea.png)

​     ![](http://junmoxiao.org.cn/idea_08.png)

~~~
    <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>        
    </mirror>
~~~

* IDEA配置maven

  ![](http://junmoxiao.org.cn/idea_09.png)



 ## 安装JDK1.8

![](http://junmoxiao.org.cn/idea_10.png)

![](http://junmoxiao.org.cn/idea_11.png)

## 安装Tomcat7

* 解决[Error running 'Tomcat 7': port out of range:-1]

![](http://junmoxiao.org.cn/idea_12.png)

![](http://junmoxiao.org.cn/idea_13.png)

## 创建maven web项目

![](http://junmoxiao.org.cn/idea_14.png)

![](http://junmoxiao.org.cn/idea_15.png)

![](http://junmoxiao.org.cn/idea_16.png)

* 创建标准目录

~~~
- src
-- main
---java
---resouces
---webapp
----WEB_INF
-----web.xml
--test
---java
---resources
~~~

* 配置tomcat7容器

  ![](http://junmoxiao.org.cn/idea_17.png)

![](http://junmoxiao.org.cn/idea_18.png)

## 运行web项目

![](http://junmoxiao.org.cn/idea_19.png)