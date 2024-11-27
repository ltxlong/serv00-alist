#!/bin/bash

# 判断是否在 public_nodejs 目录下
if [ "$(basename $(pwd))" == "public_nodejs" ]; then
    # 删除 public/index.html 文件，如果不存在则跳过
    [ -f public/index.html ] && rm public/index.html
    
    # 下载所需文件
    wget https://raw.githubusercontent.com/ltxlong/serv00-alist/main/alist/app.js 
    wget https://raw.githubusercontent.com/ltxlong/serv00-alist/main/alist/start.sh
    wget https://raw.githubusercontent.com/ltxlong/serv00-alist/main/alist/package.json
    wget https://github.com/AlistGo/alist/releases/latest/download/alist-freebsd-amd64.tar.gz
    
    # 重命名并设置权限，运行服务
    if [ -f "alist-freebsd-amd64.tar.gz" ]; then
        tar -xzf alist-freebsd-amd64.tar.gz && rm alist-freebsd-amd64.tar.gz && rm -rf temp && mv alist web.js && chmod +x web.js && ./web.js server
    fi

    # 清屏
    clear
    
    # 显示安装完成信息
    echo "已成功安装 Alist！请按照以下步骤进行配置："

    # 提示修改 app.js 文件中的端口号
    echo "1. 请修改 app.js 文件中的第 13 行，将 PORT 替换为您实际开放的端口号。"
    echo "（如果还想要开启 aria2，那么将 app.js 的第43~62行注释打开，并且修改文件中第 50 行，将 PORT 替换为您实际开放的另一个端口号）"
    
    # 提示修改配置文件
    echo "2. 请修改 data/config.json 的配置文件，以确保所有设置符合您的需求。"

else
    # 显示错误信息
    echo "检测到未在public_nodejs目录下，请确认网站添加的类型是否为nodejs"
fi
