# docker部署kafka
> https://www.cnblogs.com/360minitao/p/14665845.html
 

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash

cd /root/docker/rabbitmq

#安装zk
docker run --restart=always -d --name zookeeper -p 2181:2181 wurstmeister/zookeeper
 
#安装kafka
docker run --restart=always -d \
--name kafka \
--link zookeeper \
-p 9092:9092 \
-e KAFKA_BROKER_ID=0 \
-e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 \
-e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://192.168.1.45:9092 \
-e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092 \
wurstmeister/kafka  


#进入容器
docker exec -it kafka bash
#创建主题: my_log
/opt/kafka/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic my_log





#安装kafka-manager
docker run --restart=always -d \
--name kafka-manager \
-p 9000:9000 \
--link zookeeper \
--link kafka:kafka \
--env ZK_HOSTS=zookeeper:2181 \
sheepkiller/kafka-manager


#管理界面地址
http://192.168.1.45:9000

 

```

 