# docker部署dotnet
> 构建镜像：  https://github.com/serset/doc/tree/master/docker/dotnet/docker-image  
> 部署容器： https://github.com/serset/doc/tree/master/docker/dotnet/docker-deploy/app1  

# (x.1)支持版本  
>版本规则为   serset/dotnet:{sdk|runtime|aspnet}-{version} 。 如 serset/dotnet:sdk-6.0  

## 6.0
serset/dotnet:aspnet-6.0  
serset/dotnet:runtime-6.0  
serset/dotnet:sdk-6.0   
serset/dotnet:6.0   (等同serset/dotnet:aspnet-6.0)   

## 5.0
serset/dotnet:aspnet-5.0  
serset/dotnet:runtime-5.0  
serset/dotnet:sdk-5.0  
serset/dotnet:5.0   (等同serset/dotnet:aspnet-5.0)   

## 3.1  
serset/dotnet:aspnet-3.1  
serset/dotnet:runtime-3.1  
serset/dotnet:sdk-3.1  
serset/dotnet:3.1   (等同serset/dotnet:aspnet-3.1)   

## 2.1  
serset/dotnet:aspnet-2.1  
serset/dotnet:runtime-2.1  
serset/dotnet:sdk-2.1  
serset/dotnet:2.1   (等同serset/dotnet:aspnet-2.1)   

# (x.2)部署
## (x.x.1)创建文件夹
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


## (x.x.2)创建容器并运行
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
serset/dotnet:aspnet-2.1

```

## (x.x.3)发布项目

``` bash
cd /root/docker/app1
docker run -it --rm \
-v /etc/localtime:/etc/localtime \
-v $PWD:/root/app \
-v $PWD/nuget/packages:/root/.nuget/packages \
serset/dotnet:sdk-6.0 \
bash -c "
set -e
cd /root/app
dotnet build --configuration Release
dotnet publish --configuration Release --output /root/app/publish
"

```

## (x.x.4)容器常用命令

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
docker exec -it app1 bash

```
