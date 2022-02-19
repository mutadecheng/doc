# docker部署jellyfin影音服务器
> 支持arm架构如树莓派
> https://www.jianshu.com/p/f8ac045d8ffa


# 1.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash

mkdir -p /root/docker/jellyfin/media

cd /root/docker/jellyfin
docker run --name=jellyfin --restart=always -d \
-p 8096:8096 \
-v $PWD/config:/config \
-v $PWD/media:/media \
jellyfin/jellyfin


```


http://192.168.0.153:8096


# 3.容器常用命令

``` bash
#查看容器logs
docker logs jellyfin

#停止容器
docker stop jellyfin

#打开容器
docker start jellyfin

#重启容器
docker restart jellyfin

#删除容器
docker rm jellyfin -f


#进入容器执行命令
docker exec -it jellyfin bash

```
