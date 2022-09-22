# docker部署ss
> https://hub.docker.com/r/shadowsocks/shadowsocks-libev
> http://fhaoer.com/20190617-shadowsocks-libev/

# 1.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

> ss参数:
> -e PASSWORD=密码
> -e SERVER_PORT=端口 默认8388
> -e METHOD=加密方式 默认aes-256-gcm
> -e TIMEOUT=超时时间 默认300
> -e DNS_ADDRS=dns地址 默认8.8.8.8,8.8.4.4

``` bash

# 创建容器 
docker run --name ss --restart=always -d -e PASSWORD=test123 -e METHOD=aes-256-cfb -p 2444:8388 -p 2444:8388/udp shadowsocks/shadowsocks-libev



# 创建临时容器
docker run --rm -it -e PASSWORD=test123 -e METHOD=aes-256-cfb -p 2444:8388 -p 2444:8388/udp shadowsocks/shadowsocks-libev

 
``` 





#docker起始运行命令
ss-server -s $SERVER_ADDR -p $SERVER_PORT -k ${PASSWORD:-$(hostname)} -m $METHOD -t $TIMEOUT -d $DNS_ADDRS -u $ARGS


#手动运行
docker run --rm -it -p 12444:8388 -p 12444:8388/udp shadowsocks/shadowsocks-libev \
ss-server -s 0.0.0.0 -p 8388 -k test123 -m aes-256-cfb -t 300 -d "8.8.8.8,8.8.4.4" -u





> 客户端的配置:  
> 服务器地址：填写服务器的ipv4地址
> 服务器端口：这里填的是docker容器映射到宿主的端口，如示例中的2444端口
> 密码：填写密码，如示例中密码test123
> 加密：加密方式，如示例中aes-256-cfb



# 2.容器常用命令

``` bash
#查看容器logs
docker logs ss

#停止容器
docker stop ss

#打开容器
docker start ss

#重启容器
docker restart ss

#删除容器
docker rm ss -f

#进入容器执行命令
docker exec -it ss /bin/sh
```


# 3.其他
> copy from shadowsocks/shadowsocks-libev，故文中的镜像地址 saved/ss:libev 亦可改为 shadowsocks/shadowsocks-libev
``` bash
# 备份docker镜像
# docker login -u saved -p xxx
docker pull shadowsocks/shadowsocks-libev

docker tag shadowsocks/shadowsocks-libev saved/ss:libev
docker push saved/ss:libev

```