# docker部署qbittorrent
> https://hub.docker.com/r/superng6/qbittorrent qBittorrent 中国优化版
> https://sleele.com/2020/04/09/docker-qbittorrent-optimizing/
> https://zhuanlan.zhihu.com/p/372607837 tracker

# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

``` bash

mkdir -p /root/docker/qbittorrent

 
#(x.2)创建容器
cd /root/docker/qbittorrent
docker run --restart=always -d \
--name=qbittorrent  \
-e WEBUIPORT=8080  \
-e PUID=1026 \
-e PGID=100 \
-e TZ=Asia/Shanghai \
-p 6881:6881  \
-p 6881:6881/udp  \
-p 8080:8080  \
-v $PWD/config:/config  \
-v $PWD/downloads:/downloads \
superng6/qbittorrent:latest

http://nas.lith.cloud:8080
admin/adminadmin


```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs qbittorrent

#停止容器
docker stop qbittorrent

#打开容器
docker start qbittorrent

#重启容器
docker restart qbittorrent

#删除容器
docker rm qbittorrent -f


#进入容器执行命令
docker exec -it qbittorrent bash


```


 






