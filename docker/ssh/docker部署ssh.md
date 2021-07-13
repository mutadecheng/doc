# docker部署ssh
 
# 1.创建文件夹
> 创建目标文件夹/root/docker/ssh,把部署文件拷贝进去
 


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
docker run --restart=always -d \
--name ssh \
-p 10022:10022 \
-v /:/host \
-v /etc/localtime:/etc/localtime \
serset/ssh



#创建临时容器
docker run -it --rm \
-p 10022:10022 \
-v /:/host \
-v /etc/localtime:/etc/localtime \
serset/ssh bash

service ssh start
 
#改变密码
 

```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs ssh

#停止容器
docker stop ssh

#打开容器
docker start ssh

#重启容器
docker restart ssh

#删除容器
docker rm ssh -f


#进入容器执行命令
docker  exec -it ssh bash


#创建临时容器
docker run -it --rm serset/ssh bash

```


 






