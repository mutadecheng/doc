# docker发布dotnet
 
# 1.创建文件夹
 


# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

``` bash

#直接构建dotnet项目
cd /root/temp/svn
docker run -it --rm -v $PWD/code:/root/code -v $PWD/nuget/packages:/root/.nuget/packages --env LANG=C.UTF-8 serset/dotnet:6.0-sdk bash -c "\
cd /root/code/20.数据汇聚/21.数据汇聚控制中心/DataAggregationController; \
dotnet build --configuration Release " 


#进入bash
cd /root/temp/svn
docker run -it --rm -v $PWD/code:/root/code -v $PWD/nuget/packages:/root/.nuget/packages --env LANG=C.UTF-8 serset/dotnet:6.0-sdk bash




```
 





