# docker部署
> https://github.com/mobtitude/docker-vpn-pptp
> https://my.oschina.net/u/4315736/blog/4070487


# 1.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

> ss参数:
> -s shadowsocks-libev 参数字符串
> -p ss的运行端口
> -m ss的加密方式
> -k ss客户端密码

``` bash


#创建文件 /etc/ppp/chap-secrets

# Secrets for authentication using PAP
# client    server      secret      acceptable local IP addresses
lith    *      Commonpwd1    *


# 创建容器
docker run --restart=always -d --privileged \
--net=host \
--name vpn \
-p 1723:1723 \
-v /etc/ppp/chap-secrets:/etc/ppp/chap-secrets \
mobtitude/vpn-pptp

  
 

# 查看登录凭据
 

 
docker logs vpn

#删除容器
docker rm vpn -f

``` 

> 客户端的配置:  
> 服务器地址：填写服务器的ipv4地址
> 服务器端口：这里填的是docker容器映射到宿主的端口，如示例中的2444端口
> 密码：填写密码，如示例中密码test123
> 加密：加密方式，如示例中aes-256-cfb



# 2.容器常用命令

``` bash
#查看容器logs
docker logs vpn

#停止容器
docker stop vpn

#打开容器
docker start vpn

#重启容器
docker restart vpn

#删除容器
docker rm vpn -f

#进入容器执行命令
docker  exec -it vpn bash
```



# 3.其他
> copy from mritd/shadowsocks，故文中的镜像地址 saved/ss 亦可改为 mritd/shadowsocks  
> 参见 https://hub.docker.com/r/mritd/shadowsocks  
> 参考 https://blog.csdn.net/w191717365/article/details/90756391

``` bash
# 备份docker镜像
# docker login -u saved -p xxx
docker pull mritd/shadowsocks
docker tag mritd/shadowsocks saved/ss
docker push saved/ss
```