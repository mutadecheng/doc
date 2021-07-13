# docker部署 rabbitMq
> https://blog.csdn.net/stwuyiyu/article/details/89354767
 

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash

cd /root/docker/rabbitmq

docker run --name rabbitmq --restart=always -d \
-p 5672:5672 -p 15672:15672 \
-v $PWD/rabbitmq.conf:/etc/rabbitmq/rabbitmq.conf \
-v $PWD/rabbitmq:/var/lib/rabbitmq  \
-e RABBITMQ_DEFAULT_USER=guest \
-e RABBITMQ_DEFAULT_PASS=guest \
rabbitmq:3-management
 

#管理界面地址(默认账户： guest/guest)
http://192.168.56.213:15672

 

```



Config file		/etc/rabbitmq/rabbitmq.conf
Database directory	/var/lib/rabbitmq/mnesia/rabbit@d96b8aa945ff
Log file		<stdout>


# 3.容器常用命令

``` bash
#查看容器logs
docker logs rabbitmq

#停止容器
docker stop rabbitmq

#打开容器
docker start rabbitmq

#重启容器
docker restart rabbitmq

#删除容器
docker rm rabbitmq -f

#进入容器执行命令
docker  exec -it rabbitmq bash

```
 

 