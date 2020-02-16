#!/bin/sh

#判断是否存在public文件夹
if [ -d "F:/blog/public" ];then
  rm -rf F:/blog/public
  echo "文件夹存在"
  else
  echo "文件夹不存在"
fi

#进入目录
cd F:/blog

git init

git add .

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"


# Push source and build repos.
git push -f git@github.com:MrYaoYuWei/Hugo-Source-Code.git  master


#  build hugo.
hugo --theme=dream --baseUrl="http://MrYaoYuWei.github.io" -D



#Go To Public folder
cd F:/blog/public

git init

#Add changes to git.
git add .

# Commit changes.

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.

git push -f git@github.com:MrYaoYuWei/MrYaoYuWei.github.io.git  master


