# docker部署
> https://www.home-assistant.io/installation/linux


# 1.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  


``` bash

mkdir -p /root/docker/HomeAssistant

cd /root/docker/HomeAssistant
docker run --restart=always -d --privileged \
--name homeassistant \
--net=host \
-v /etc/localtime:/etc/localtime \
-v $PWD/config:/config \
ghcr.io/home-assistant/home-assistant:stable


http://192.168.20.20:8123
lith/Commonpwd1



```




# 3.容器常用命令

``` bash
#查看容器logs
docker logs homeassistant

#停止容器
docker stop homeassistant

#打开容器
docker start homeassistant

#重启容器
docker restart homeassistant

#删除容器
docker rm homeassistant -f


#进入容器执行命令
docker exec -it homeassistant bash

```
