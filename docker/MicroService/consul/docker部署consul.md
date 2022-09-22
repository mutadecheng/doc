# docker部署
> 参考 https://www.jianshu.com/p/4ddbf2611875


# 1.创建文件夹
> 把部署文件（本文件夹）拷贝进去


# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash


#启动一个单独节点consul agent 
docker run -d --name=consul --restart=always -p 8500:8500 -v /etc/localtime:/etc/localtime consul


#界面
http://192.168.1.45:8500 

```



# 3.容器常用命令

``` bash
#常用命令

#查看容器logs
docker logs consul

#停止容器
docker stop consul

#打开容器
docker start consul

#重启容器
docker restart consul

#删除容器
docker rm consul -f


#进入容器执行命令
docker exec -it consul bash 


```



 