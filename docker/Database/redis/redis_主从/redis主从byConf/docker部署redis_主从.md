# docker部署容器
> 参考 https://www.r9it.com/20190826/docker-build-redis-master-slave.html

# 1.创建文件夹
mkdir -p /root/docker/redis




# 2.创建配置文档
#(x.x.1)下载标准的配置文件
wget -c http://download.redis.io/redis-stable/redis.conf

#(x.x.2)复制并修改配置文件 master/redis.conf
dir /data 
appendonly yes
requirepass 123456 #设置连接密码 
bind * -::*    #允许外网访问

#(x.x.3)复制并修改配置文件 slave1/redis.conf
dir /data 
appendonly yes
requirepass 123456 #设置连接密码 
bind * -::*    #允许外网访问
replicaof redis-master 6379
masterauth 123456 #连接密码


# 3.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> redis-server --appendonly yes 在容器执行redis-server启动命令，并打开redis持久化配置  
> --requirepass "123456" 设置密码  



``` bash


#启动master
cd /root/docker/redis/master
docker run --name redis-master --restart=always -d \
-p 6379:6379 \
-v $PWD/data:/data \
-v $PWD/redis.conf:/etc/redis/redis.conf \
redis:6.2.5 \
redis-server /etc/redis/redis.conf




#启动slave1
cd /root/docker/redis/slave1
docker run --name redis-slave1 --restart=always -d \
--link redis-master:master \
-p 6380:6379 \
-v $PWD/data:/data \
-v $PWD/redis.conf:/etc/redis/redis.conf \
redis:6.2.5 \
redis-server /etc/redis/redis.conf


#启动slave2
cd /root/docker/redis/slave2
docker run --name redis-slave2 --restart=always -d \
--link redis-master:master \
-p 6381:6379 \
-v $PWD/data:/data \
-v $PWD/redis.conf:/etc/redis/redis.conf \
redis:6.2.5 \
redis-server /etc/redis/redis.conf



```



# 4.容器常用命令

``` bash
#查看容器logs
docker logs redis-master
docker logs redis-slave1


#停止容器
docker stop redis-master

#打开容器
docker start redis-master

#重启容器
docker restart redis-master

#删除容器
docker rm redis-master -f
docker rm redis-slave1 -f

#进入容器执行命令
docker exec -it redis-master bash
``` 








# 5.连接测试

#连接主节点，添加数据
docker run -it --rm --link redis-master:master redis:6.2.5 bash
redis-cli -h master -p 6379 -a 123456

set name "hello Redis"
get name


#连接从节点1
docker run -it --rm --link redis-slave2:slave redis:6.2.5 bash
redis-cli -h slave -p 6379 -a 123456

get name


#通过shell脚本管道往Master节点灌入10w条数据
docker run -it --rm --link redis-master:master redis:6.2.5 bash
for((i=1;i<=100000;i++)); do echo "set k$i v$i" >> /tmp/redisTest.txt; done;
cat /tmp/redisTest.txt | redis-cli -h master -p 6379 -a 123456 --pipe

#从slave1中查看是否同步
