# docker搭建私有镜像仓库UI
> https://hub.docker.com/r/hyper/docker-registry-web/



-------------------------------
 
#(x.2)创建容器并运行
(--name 容器名称，可自定义)
(--restart=always 自动重启)
(-v /etc/localtime:/etc/localtime)挂载宿主机localtime文件解决容器时间与主机时区不一致的问题
(-v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data)
(--net=host 网络直接使用宿主机网络)（-p 6022:6022 端口映射）


docker run -d -p 1101:8080 --name registry-web \
-e REGISTRY_URL=http://nas.i.lith.cloud:1100/v2 \
-e REGISTRY_NAME=nas.i.lith.cloud:1100 \
-e REGISTRY_READONLY=false \
hyper/docker-registry-web 



# 打开地址 
http://nas.i.lith.cloud:1101
 
 
#---------------------------------------
#常用命令

#查看容器logs
docker logs registry-web

#在容器内执行命令行
docker exec -it registry-web /bin/sh

#停止容器
docker stop registry-web

#打开容器
docker start registry-web

#重启容器
docker restart registry-web


#删除容器
docker rm registry-web -f
