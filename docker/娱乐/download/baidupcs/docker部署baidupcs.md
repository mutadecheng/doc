# docker部署baidupcs
> https://hub.docker.com/r/auska/docker-baidupcs

# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

``` bash

mkdir -p /root/docker/baidupcs

 docker rm baidupcs -f
#(x.2)创建容器
docker run --name baidupcs  --restart=always -d \
-e PUID=0 \
-e PGID=0 \
-e TZ=Asia/Shanghai \
-e PORT=1999 \
-p 1999:1999 \
-v /root/docker/baidupcs/downloads:/root/Downloads \
auska/docker-baidupcs


docker create --name=baidupcs \

-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-e PORT=1999 \  #(port should be greater than 1024)
-p 1999:1999 \  
auska/docker-baidupcs

PUID=1001 and PGID=1001. To find yours use id user as below:
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)

http://nas.i.lith.cloud:1999



#BDUSS登录
浏览器登录百度官网后通过浏览器开发工具获取Cookies.BDUSS


```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs baidupcs

#停止容器
docker stop baidupcs

#打开容器
docker start baidupcs

#重启容器
docker restart baidupcs

#删除容器
docker rm baidupcs -f


#进入容器执行命令
docker exec -it baidupcs bash


```


 






