# serv00-alist
在serv00上一键部署alist，并且实现访问即拉起和保持更新最新版


基于 [jinnan11/serv00-api](https://github.com/jinnan11/serv00-api) 修改

区别：本项目进行精简（注释了多余代码，需要时可以打开，但打开的话就需要用两个端口了），只用一个端口（serv00限制每个账号只有3个端口，省着用）

步骤：

#### 1、域名托管到cloudflare，如 example.com

#### 2、新增子域名的A记录，解析到serv00的一个ip（随便选分配的两个中的一个），

如 A记录 alist.example.com xxx.xxx.xxx.xxx

#### 3、登录serv00 panel，Add website，node js，v22.x.x，访问 alist.example.com 看是否成功

#### 4、开一个serv00 tcp port，并且新建一个mysql数据库，记住相关配置

#### 5、登录serv00 panel的file_manager，同时登录SSH

#### 6、执行 

```
cd ~/domains/网站/public_nodejs
```

记得将这里面的 “网站” 替换为刚刚的子域名 alist.example.com

#### 7、下载AList和运行Node.js的基础文件：

```
bash <(curl -s https://raw.githubusercontent.com/ltxlong/serv00-alist/main/install_alist.sh)
```

#### 8、按照提示修改相关端口：

请修改 app.js 文件中的第 13 行，将 PORT 替换为您实际开放的端口号

（如果还想要开启 aria2，那么将 app.js 的第43~62行注释打开，并且修改文件中第 50 行，将 PORT 替换为您实际开放的另一个端口号）

请修改 data/config.json 的配置文件，以确保所有设置符合您的需求：

参考使用[Serv00免费虚拟主机部署Alist](https://zhuanlan.zhihu.com/p/680607217)

主要修改了CDN、database、scheme三个部分，其中CDN可以在Alist的官方文档找到，请选择你本地网络连接速度最快的一个。

scheme部分，我选择修改address为127.0.0.1本地回环，是为了避免被他人使用http://ip:port 的方式进行访问。至于自己怎么访问，我在本文后面的部分会进行介绍。port要改成自己前面放行的端口。

database部分，type需要改成`mysql`，host填写你在注册邮件中看到的mysql的地址，port是默认的3306，用户名、密码、数据库名则按照你创建的情况进行填写

补充

CDN如果改的不对，首页加载不出来的！可以修改CDN为：https://jsd.onmicrosoft.cn/gh/alist-org/web-dist@$version/dist/ 

数据库的表前缀修改为：ALIST_

第25行的端口号需要和app.js中的第13行端口号保持一致

第80行的端口号5246改为0

#### 9、启动一次AList，查看运行是否正常

```
./web.js server
```

运行正常，记得把管理员用户的密码记住。接着使用Ctrl+c停止运行。

若要直接命令设置新的管理员密码，scheme的address不能设置为127.0.0.1，可以修改完密码再改scheme address：

```
./web.js admin set NEW_PASSWORD
```

也可以不用命令修改密码，直接登录alist管理后台修改密码也行

#### 10、安装npm22:

```
npm22 install
```

完成

自动启动：
你可以通过访问网站对项目进行唤醒。如果你需要保活，可以使用以下公共服务对网页进行监控：

[cron-job.org](https://console.cron-job.org)

[UptimeRobot](https://uptimerobot.com)

同时，你也可以选择自建 [Uptime-Kuma](https://github.com/louislam/uptime-kuma) 等服务进行监控。

相关网址：

Serv00 进程保活最终解决方案：https://saika.us.kg/2024/08/15/serv00-keep-alive 

Serv00 部署 AList：https://github.com/jinnan11/alist-freebsd 

AList 官方说明文档：https://alist.nn.ci/zh/ 
