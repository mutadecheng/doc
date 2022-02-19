# docker部署cloud-torrent
> https://www.freesion.com/article/1314673178/


# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

``` bash

mkdir -p /root/docker/torrent



 
#(x.2)创建容器
cd /root/docker/torrent
docker run --name torrent --restart=always -d \
-p 3000:3000 \
-v $PWD/downloads:/downloads \
jpillora/cloud-torrent



#访问地址
http://192.168.20.20:3000



```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs torrent

#停止容器
docker stop torrent

#打开容器
docker start torrent

#重启容器
docker restart torrent

#删除容器
docker rm torrent -f


#进入容器执行命令
docker exec -it torrent bash


```


 






