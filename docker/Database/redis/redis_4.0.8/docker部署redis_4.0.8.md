# docker部署容器
> 参考 https://www.cnblogs.com/sxdcgaq8080/p/9522524.html

# 1.创建文件夹
mkdir -p /root/docker/redis_4.0.8/data


# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> redis-server --appendonly yes 在容器执行redis-server启动命令，并打开redis持久化配置  
> --requirepass "123456" 设置密码  



``` bash
cd /root/docker/redis_4.0.8
docker run --name redis --restart=always -d \
-p 6379:6379 \
-v $PWD/data:/data  \
redis:4.0.8 \
redis-server --appendonly yes
```



# 3.容器常用命令

``` bash
#查看容器logs
docker logs redis

#停止容器
docker stop redis

#打开容器
docker start redis

#重启容器
docker restart redis

#删除容器
docker rm redis -f

#进入容器执行命令
docker exec -it redis bash
``` 