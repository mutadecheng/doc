# docker部署
> 参考 https://www.xiaoz.me/archives/16114
 

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

Web  - 端口 80、443 (TLS)
SMTP - 端口 25、465 (TLS)、587		Simple Mail Transfer Protocol,一组用于从源地址到目的地址传输邮件的规范，通过它来控制邮件的中转方式
POP3 - 端口 110、995 (TLS)		Post Office Protocol 3, 支持使用客户端远程管理在服务器上的电子邮件
IMAP - 端口 143、993 (TLS)		Internet Mail Access Protocol，用来从本地邮件客户端（Outlook Express、Foxmail等）访问远程服务器上的邮件

``` bash

mkdir -p /root/docker/mailserver

cd /root/docker/mailserver
docker run -d --restart=always \
--name mailserver \
-p 1000:80 -p 1001:443 -p 25:25 -p 110:110 -p 143:143 -p 465:465 -p 587:587 -p 993:993 -p 995:995 \
-e TZ=Asia/Shanghai \
-v $PWD/data:/data \
-h "lith.cloud" \
analogic/poste.io
 


```

# 配置域名
mail.lith.cloud	CNAME	k.lith.cloud
smtp.lith.cloud	CNAME	k.lith.cloud
pop.lith.cloud	CNAME	k.lith.cloud
imap.lith.cloud	CNAME	k.lith.cloud
lith.cloud		MX	k.lith.cloud
lith.cloud		txt	v=spf1 mx ~all

# 登录
https://192.168.20.20:1001/

admin@lith.cloud
Admin0123


# 设置DKIM验证
登录 - Virtual domains - 点击对应域名 - DKIM key - 创建key，并按照要求设置txt记录解析。

s20220214554._domainkey.lith.cloud. IN TXT "k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAysB02eMrQ1/tfLozzZNoAe46dziHmX8uxqxOzn1rA5vASbH7GdTWCaie16iY+Hla0lr7L/t1e4iLjfFJDV/OyF4hBjRft4kEe1fXBp89u3fySd/H1IKrq/9u/mVq9Ta+5E3M/SxbP4bdd+/j2lOoOgiKqEjBx/cv23rbl5JFlUOmWHk4FnVST+cbW99Cl1o1CFM7dJDBtfPf2aZn4psFHpCQS19PHGoiK95AxyCoXwYyV81qBLZZU/XJu3Wl/u/C567lQzn5+oQpXfy6yK9cB6oIxuPSsxaJFuEH7B1/Xnnu04EkLWLN6I+JYOZIVR0RPbjwb0WZCFQSiZF+lAr4SwIDAQAB"

# 设置PTR反向解析
> 添加SPF/DKIM/PTR解析，可提高邮件可信度，从而降低邮件进入垃圾箱的几率，必不可少的关键步骤


# 设置TLS SSL

# 邮箱登录
https://192.168.20.20:1001/webmail

# 系统管理
https://192.168.20.20:1001/admin/login


#------------------------------------------------
# 3.容器常用命令

``` bash
#查看容器logs
docker logs mailserver

#停止容器
docker stop mailserver

#打开容器
docker start mailserver

#重启容器
docker restart mailserver

#删除容器
docker rm mailserver -f

#进入容器执行命令
docker exec -it mailserver bash
```
 


 
