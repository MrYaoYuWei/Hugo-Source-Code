---
title: "Metasploit基本使用"
date: 2020-02-21T15:49:20+08:00
categories: ['Kali']
tags: ['安全渗透']
---

Metasploit框架基本使用

<!--more-->



##  Metasploit  简介 

> Metasploit是一个免费的、可下载的框架，通过它可以很容易对计算机软件漏洞实施攻击。它本身 附带数百个已知软件漏洞的专业级漏洞攻击工具
>
> 官网： https://www.metasploit.com/

## Metasploit  体系框架

![](http://junmoxiao.org.cn/20200221155316.png)

> Rex是整个框架所依赖最基础的一些组件 PostgreSQL 以及MySQL数据库支持 日志子系统、渗透攻击支持例程等
>
> framework-core库 实现所有不各种类型的上层模块及插件的交互接口
>
> framework-base库扩展了framework-core 用于支持用户接口与功能程序调用框架本身功能及框架集成模块
>
> 辅助模块（Aux)、渗透攻击模块（Exploits)、后渗透攻击模块（Post)、攻击载荷模块（payloads)、 编码器模块（Encoders)、空指令模块（Nops)
>
> 插件 能够扩充框架的功能，或组装已有功能构成高级特性的组件 Nmap Nessus、OpenVAS漏洞扫描器等，为用户接口提供一些新的功能
>
> 接口 包括msfconsole控制终端、msfcli 命令行、msfgui 图形化界面、armitage图形化界面 以及msfapi 进程调用接口
>
> 功能程序 还提供了一系列可直接运行的功能程序 msfpayload、msfencode和msfvenom 可以将攻击载荷封装为可执行文件、C语言、JavaScript语言等多种形式

## Metasploit目录结构 



![](http://junmoxiao.org.cn/20200221161046.png)



## Metasploit 基本使用

* Metasploit程序需要使用 Postgresql 数据库(对象-关系型数据库管理系统)

~~~
systemctl restart postgresql
systemctl enable postgresql
msfdb reinit
cat /usr/share/metasploit-framework/config/database.yml
~~~

* 启动Metasploit

  ~~~
  msfconsole
  ~~~

  * 帮助文档

    ~~~
    msf5 > help
    ~~~

* Core Commands

  >connect  用于远程连接主机，用于内网渗透
  >
  >get  获取特定于上下文的变量的值
  >
  >help  帮助菜单
  >
  >history 显示命令历史
  >
  >quit  退出控制台
  >
  >sessions 转储会话列表并显示有关会话的信息
  >
  > set  将特定于上下文的变量设置为一个值
  >
  >threads  线程查看和操作后台线程
  >
  >unset  取消设置一个多个特定于上下文的变量
  >
  >version 显示框架和控制台库版本号
  >
  >unload  卸载框架揑件

e.g

~~~
msf5 > sessions -h
Usage: sessions [options] or sessions [id]

Active session manipulation and interaction.

OPTIONS:

    -C <opt>  Run a Meterpreter Command on the session given with -i, or all
    -K        Terminate all sessions
    -S <opt>  Row search filter.
    -c <opt>  Run a command on the session given with -i, or all
    -d        List all inactive sessions
    -h        Help banner
    -i <opt>  Interact with the supplied session ID
    -k <opt>  Terminate sessions by session ID and/or range
    -l        List all active sessions
    -n <opt>  Name or rename a session by ID
    -q        Quiet mode
    -s <opt>  Run a script or module on the session given with -i, or all
    -t <opt>  Set a response timeout (default: 15)
    -u <opt>  Upgrade a shell to a meterpreter session on many platforms
    -v        List all active sessions in verbose mode
    -x        Show extended information in the session table

Many options allow specifying session ranges using commas and dashes.

For example:  sessions -s checkvm -i 1,3-5  or  sessions -k 1-2,5,6

~~~

~~~
e.g
For example:  sessions -s checkvm -i 1,3-5  or  sessions -k 1-2,5,6
~~~



~~~
msf5 > connect xuegod.cn 80
[*] Connected to xuegod.cn:80
get
HTTP/1.1 400 Bad Request
Server: nginx/1.6.2
Date: Fri, 21 Feb 2020 08:59:21 GMT
Content-Type: text/html
Content-Length: 172
Connection: close

<html>
<head><title>400 Bad Request</title></head>
<body bgcolor="white">
<center><h1>400 Bad Request</h1></center>
<hr><center>nginx/1.6.2</center>
</body>
</html>
~~~

* Module Commands

  >back 从当前上下文返回
  >
  >info  显示有关一个或多个模块的信息
  >
  >options 显示全局选项或一个或多个模块
  >
  >search 搜索模块名称和描述
  >
  >show  显示给定类型的模块或所有模块
  >
  >use  按名称选择加载模块

  e.g

  ~~~
  msf5 > show
  [-] Argument required
  
  [*] Valid parameters for the "show" command are: all, encoders, nops, exploits, payloads, auxiliary, post, plugins, info, options
  [*] Additional module-specific parameters are: missing, advanced, evasion, targets, actions
  
  ~~~

  ~~~
  show exploits
  show payloads
  show auxiliary
  show post
  show options
  show targets
  ~~~

  

  ~~~
  msf5 > search -h
  Usage: search [<options>] [<keywords>]
  
  If no options or keywords are provided, cached results are displayed.
  
  OPTIONS:
    -h                Show this help information
    -o <file>         Send output to a file in csv format
    -S <string>       Search string for row filter
    -u                Use module if there is one result
  
  Keywords:
    aka         :  Modules with a matching AKA (also-known-as) name
    author      :  Modules written by this author
    arch        :  Modules affecting this architecture
    bid         :  Modules with a matching Bugtraq ID
    cve         :  Modules with a matching CVE ID
    edb         :  Modules with a matching Exploit-DB ID
    check       :  Modules that support the 'check' method
    date        :  Modules with a matching disclosure date
    description :  Modules with a matching description
    fullname    :  Modules with a matching full name
    mod_time    :  Modules with a matching modification date
    name        :  Modules with a matching descriptive name
    path        :  Modules with a matching path
    platform    :  Modules affecting this platform
    port        :  Modules with a matching port
    rank        :  Modules with a matching rank (Can be descriptive (ex: 'good') or numeric with comparison operators (ex: 'gte400'))
    ref         :  Modules with a matching ref
    reference   :  Modules with a matching reference
    target      :  Modules affecting this target
    type        :  Modules of a specific type (exploit, payload, auxiliary, encoder, evasion, post, or nop)
  
  Examples:
    search cve:2009 type:exploit
  
  
  ~~~

  >CVE概述 CVE 的英文全称是“Common Vulnerabilities & Exposures”公共漏洞和暴露。CVE 就好像是一个字典表，为广泛认同的信息安全漏洞或者已经暴露出来的弱点给出一个公共的名称，如果有 CVE名称，就可以快速地在任何其它 CVE兼容的数据库中找到相应修补的信息
  >
  >e.g
  >
  >~~~
  >msf5 > search  cve:2017-8464 
  >
  >Matching Modules
  >================
  >
  >   #  Name                                              Disclosure Date  Rank       Check  Description
  >   -  ----                                              ---------------  ----       -----  -----------
  >   0  exploit/windows/fileformat/cve_2017_8464_lnk_rce  2017-06-13       excellent  No     LNK Code Execution Vulnerability
  >   1  exploit/windows/local/cve_2017_8464_lnk_lpe       2017-06-13       excellent  Yes    LNK Code Execution Vulnerability
  >~~~

  ~~~
  
  msf5 > search -u ms08_067
  
  Matching Modules
  ================
  
     #  Name                                 Disclosure Date  Rank   Check  Description
     -  ----                                 ---------------  ----   -----  -----------
     0  exploit/windows/smb/ms08_067_netapi  2008-10-28       great  Yes    MS08-067 Microsoft Server Service Relative Path Stack Corruption
  
  
  [*] Using exploit/windows/smb/ms08_067_netapi
  
  ~~~

  ~~~
  search name:
  search type:
  search cve:
  search platform:
  search path:
  ~~~

  

* Job Commands

  >jobs 显示和管理作业
  >
  >kill 杀死一个工作

  ~~~
  msf5 > jobs -h
  Usage: jobs [options]
  
  Active job manipulation and interaction.
  
  OPTIONS:
  
      -K        Terminate all running jobs.
      -P        Persist all running jobs on restart.
      -S <opt>  Row search filter.
      -h        Help banner.
      -i <opt>  Lists detailed information about a running job.
      -k <opt>  Terminate jobs by job ID and/or range.
      -l        List all running jobs.
      -p <opt>  Add persistence to job by job ID
      -v        Print more detailed info.  Use with -i and -l
  
  ~~~

  ~~~
  e.g
  jobs -K
  jobs -i ID
  ~~~

  

* Database Backend Commands

  >db_connect 连接到现有的数据库
  >
  >db_disconnect 断开当前数据服务
  >
  >db_export 导出包含数据库内容的文件
  >
  >db_import 导入扫描结果文件
  >
  >db_nmap 执行nmap并自动记录输出
  >
  >db_rebuild_cache 重建数据库存储的模块缓存
  >
  >db_remove  删除保存的数据服务条目
  >
  >db_save 保存当前连接数据库的数据
  >
  >db_status 显示当前数据库服务的状态
  >
  >hosts  列出数据库中的所有主机
  >
  >services 列出数据库中的所有服务
  >
  >workspace 在数据库工作区之间切换

* Credentials Backend Commands

>creds 列出数据库中的所有凭据

* Exploit Commands

  >check 检查目标是否有该漏洞
  >
  >exploit 执行一次渗透攻击
  >
  >run  全局执行一次渗透攻击
  >
  >rexploit 重新加载模块并执行一次渗透攻击