# docker部署postgis
> 参考 https://www.cnblogs.com/zt2710/p/11429372.html  
> https://hub.docker.com/r/kartoza/postgis  

# 1.创建文件夹
> 把部署文件（本文件夹）拷贝进去


# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> -e POSTGRES_PASSWORD=123456 密码

``` bash

mkdir -p /root/docker/postgres
cd /root/docker/postgres

docker run --restart=always -d \
--name postgres \
-p 5432:5432 \
-v /etc/localtime:/etc/localtime \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD='123456' \
-e ALLOW_IP_RANGE=0.0.0.0/0 \
kartoza/postgis:9.6-2.4




-v $PWD/data:/var/lib/postgresql/data \


#使用navcat 或 pgAdmin登录
postgres
postgres
123456


```









# 3.容器常用命令

``` bash
#常用命令

#查看容器logs
docker logs postgres

#停止容器
docker stop postgres

#打开容器
docker start postgres

#重启容器
docker restart postgres

#删除容器
docker rm postgres -f


#进入容器执行命令
docker exec -it postgres bash
   
```


