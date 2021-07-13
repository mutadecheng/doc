# docker部署
> nuget_server_php


# 1.创建文件夹
``` bash
mkdir -p /root/docker/nuget/db 
mkdir -p /root/docker/nuget/packagefiles 
```

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash
cd /root/docker/nuget
docker run --name=nuget --restart=always -d \
-p 10008:80 \
-v $PWD/db:/var/www/db \
-v $PWD/packagefiles:/var/www/packagefiles \
-e NUGET_API_KEY=ee28314c-f7fe-2550-bd77-e09eda3d0119 \
saved/nuget


# 查看是否安装成功
curl http://127.0.0.1:10008/Search\(\)

# http://127.0.0.1:10008/Search()
# http://nuget.sers.cloud:10008/Search()?$filter=IsLatestVersion&searchTerm=''&targetFramework='netstandard2.0%7Cnetcoreapp2.1'&includePrerelease=false&$skip=0&$top=26&semVerLevel=2.0.0

```


# 3.容器常用命令

``` bash
#查看容器logs
docker logs nuget

#停止容器
docker stop nuget

#打开容器
docker start nuget

#重启容器
docker restart nuget

#删除容器
docker rm nuget -f

#进入容器执行命令
docker  exec -it nuget /bin/sh
```

# 4.nuget包管理命令

``` cmd
::dotnet 推送nuget包
dotnet nuget push H:\code\AliEcsSvn\Sers2.1.1\dotnet\Doc\Release\nuget\Vit.Core.2.1.1.51.nupkg -k ee28314c-f7fe-2550-bd77-e09eda3d0119  -s http://nuget.sers.cloud:10008

::从指定Source上移除一个包，必须指定版本
dotnet nuget delete Vit.Core 2.1.1.51 -k ee28314c-f7fe-2550-bd77-e09eda3d0119 -s http://nuget.sers.cloud:10008

```


# 5.其他
> copy from sunside/simple-nuget-server:0.5，故文中的镜像地址 saved/nuget 亦可改为 sunside/simple-nuget-server:0.5  
> 参见 https://hub.docker.com/r/sunside/simple-nuget-server  
> 参考 https://www.cnblogs.com/cqhaibin/p/8051834.html

``` bash
# 备份docker镜像
# docker login -u saved -p xxx
docker pull sunside/simple-nuget-server:0.5
docker tag sunside/simple-nuget-server:0.5 saved/nuget:0.5
docker push saved/nuget:0.5
docker tag sunside/simple-nuget-server:0.5 saved/nuget
docker push saved/nuget
```