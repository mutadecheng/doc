# docker 压测
> https://hub.docker.com/r/joedval/stress

 


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
docker run --name stress -d -m 2048m joedval/stress --vm 4 --vm-bytes 100m
docker run --name stress2 -d -m 2048m joedval/stress --vm 4 --vm-bytes 100m
docker run --name stress3 -d -m 2048m joedval/stress --vm 4 --vm-bytes 300m
docker run --name stress4 -d -m 2048m joedval/stress --vm 4 --vm-bytes 300m
docker run --name stress5 -d joedval/stress --vm 1 --vm-bytes 1000m
docker run --name stress6 -d joedval/stress --vm 1 --vm-bytes 1000m

#创建临时容器
docker run -it --rm joedval/stress --vm 4 --vm-bytes 100m

 
#Stress only on the first core
docker run -it --rm joedval/stress --cpu 2

#Stress Memory to the same capacity allowed with swap 
docker run -it --rm -m 128m joedval/stress --vm 1 --vm-bytes 256M --vm-hang 0
 

```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs stress

#停止容器
docker stop stress

#打开容器
docker start stress

#重启容器
docker restart stress

#删除容器
docker rm stress -f


#进入容器执行命令
docker exec -it stress bash



```


 






