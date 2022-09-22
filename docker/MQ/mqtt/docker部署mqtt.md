# docker部署
> https://hub.docker.com/r/emqx/emqx
> https://www.cnblogs.com/yourstars/p/15247707.html
 

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash

#初始化文件
cd /root/docker/mqtt
chmod -R 777 /root/docker/mqtt
docker run --rm -it -v $PWD:/data emqx/emqx:4.4.1 bash -c 'cp -rf /opt/emqx/data /data/data; cp -rf /opt/emqx/etc /data/etc;'

#创建容器
cd /root/docker/mqtt
docker run --name mqtt --restart=always -d \
-p 18083:18083 -p 1883:1883 -p 8083:8083 -p 8084:8084 \
-v /etc/localtime:/etc/localtime \
-v $PWD/data:/opt/emqx/data \
-v $PWD/etc:/opt/emqx/etc \
-v $PWD/log:/opt/emqx/log \
-e EMQX_NAME=foo_emqx \
-e EMQX_HOST=127.0.0.1 \
emqx/emqx:4.4.1


#管理页面(默认账户： admin/public)
http://192.168.20.20:18083

1883：MQTT 协议端口
8883：MQTT/SSL 端口
8083：MQTT/WebSocket 端口
8080：HTTP API 端口
18083：Dashboard 管理控制台端口


```

# 3.收发测试
> https://blog.csdn.net/weixin_41656968/article/details/80187955
#订阅
docker run -it --rm eclipse-mosquitto sh
mosquitto_sub -h 192.168.20.20 -t hello

#发布
docker run -it --rm eclipse-mosquitto sh
mosquitto_pub -h 192.168.20.20 -t hello -m "hello world!"  




# 4.容器常用命令

``` bash
#查看容器logs
docker logs mqtt

#停止容器
docker stop mqtt

#打开容器
docker start mqtt

#重启容器
docker restart mqtt

#删除容器
docker rm mqtt -f

#进入容器执行命令
docker exec -it mqtt bash

```
 

 