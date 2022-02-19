# docker部署node
 
# 1.创建文件夹
> 创建目标文件夹/root/docker/node,把部署文件拷贝进去



# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

``` bash

 
#创建容器
cd /root/docker/node
docker run --restart=always -d \
--name node \
-v /etc/localtime:/etc/localtime \
-v $PWD/app:/root/app \
node:17-alpine3.12



#创建临时容器
cd /root/docker/node
docker run -it --rm \
-v /etc/localtime:/etc/localtime \
-v $PWD/app:/root/app \
node:17-alpine3.12 sh

#查看版本
node -v

```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs node

#停止容器
docker stop node

#打开容器
docker start node

#重启容器
docker restart node

#删除容器
docker rm node -f


#进入容器执行命令
docker exec -it node sh



```


 






