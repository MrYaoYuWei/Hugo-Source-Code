---
title: "Hugo搭建"
date: 2019-12-24T19:06:46+08:00
lastmod: 2019-12-26T19:06:46+08:00
author: 姚先生
categories: ['Hugo']
tags: ['博客']
---

How to build Hugo blog...

<!--more-->

### 下载Hugo 
- https://github.com/gohugoio/hugo/releases

### 配置hugo命令 
- hugo.exe

### 创建Hugo站点 
- hugo new site (blog)

### 配置Hugo主题 
- https://themes.gohugo.io/ 
- [source code][1]
[1]: https://github.com/MrYaoYuWei/Hugo-Source-Code

### 自定义文章  
- hugo new post/(blog.md)

### 自定义描述 
- hugo new about/(desc.md)

### 部署远程服务器 

- baseurl = "https://MrYaoYuWei.github.io"

- hugo --theme=(dream) --baseUrl=https://MrYaoYuWei.github.io --buildDrafts

### 上传远程仓库

- cd E:\site\blog\public

- git add .

- git commit -m

- git push git@github.com:MrYaoYuWei/MrYaoYuWei.github.io.git  master

### 写作规范

- lastmod: 2019-12-24T19:06:46+08:00
- author: xxx
- cover: /img/xxx.jpg
- 分类:categories: ['xxx']
- 标签:tags: ['xxx']
- [自动化上传脚本][1]

[1]: https://github.com/MrYaoYuWei/Hugo-Source-Code/blob/master/deploy.sh
