# docker部署dotnet
 
# 1.创建文件夹
> 创建文件目标文件夹/root/docker/app1,把部署文件拷贝进去  
> 创建 startup.sh 文件并指定启动命令(按实际情况修改)  

``` bash
# /root/app/startup.sh


# run on back
# sh /root/app/App2.sh > /root/app/App2.log 2>&1 &


# run on front
# sh /root/app/app1.sh > /root/app/app1.log 2>&1


# run on front
echo "start dotnet app in docker"
cd /root/app/app1
dotnet app1.dll


# run on front
# while [ 1 -lt 2 ]
# do
# 	sleep 3600
# done

```


# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash
cd /root/docker/app1
docker run --restart=always -d \
-p 6022:6022 \
--name=app1 \
-v /etc/localtime:/etc/localtime \
-v $PWD:/root/app \
serset/dotnet:2.1

```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs app1

#停止容器
docker stop app1

#打开容器
docker start app1

#重启容器
docker restart app1

#删除容器
docker rm app1 -f


#进入容器执行命令
docker  exec -it app1 bash

```
