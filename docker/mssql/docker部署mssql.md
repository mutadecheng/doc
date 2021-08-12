# docker部署mssql
> 参考 https://segmentfault.com/a/1190000014232366
> https://hub.docker.com/_/microsoft-mssql-server

#获取镜像的标签列表
https://mcr.microsoft.com/v2/mssql/server/tags/list


docker pull mcr.microsoft.com/mssql/server:2017-latest
docker pull mcr.microsoft.com/mssql/server:2019-latest
docker pull mcr.microsoft.com/mssql/server:2019-CU11-ubuntu-20.04

 

# 1.创建文件夹
> 把部署文件（本文件夹）拷贝进去


# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> -e 环境变量

``` bash
 
# 部署mssql 2017
docker run --restart=always -d \
--name mssql \
-p 1433:1433 \
-v /etc/localtime:/etc/localtime \
-m 5120m \
-e 'ACCEPT_EULA=Y' \
-e 'SA_PASSWORD=LongLongPassword1!' \
mcr.microsoft.com/mssql/server:2017-latest

# 192.168.56.213,1433
# sa/LongLongPassword1!

```

``` bash
 
# 部署mssql 2019
mkdir -p /root/docker/mssql/data
chmod 777 -R /root/docker/mssql/data
cd /root/docker/mssql
docker run --restart=always -d \
--name mssql2019 \
-p 1434:1433 \
-v $PWD/data:/data \
-v /etc/localtime:/etc/localtime \
-m 5120m \
-e 'ACCEPT_EULA=Y' \
-e 'SA_PASSWORD=LongLongPassword1!' \
mcr.microsoft.com/mssql/server:2019-latest

# 192.168.3.221,1434
# sa/LongLongPassword1!

```



# 3.容器常用命令

``` bash
#常用命令

#查看容器logs
docker logs mssql2019

#停止容器
docker stop mssql2019

#打开容器
docker start mssql2019

#重启容器
docker restart mssql2019

#删除容器
docker rm mssql2019 -f


#进入容器执行命令
docker exec -it mssql2019 bash

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'LongLongPassword1!'


#创建数据库
CREATE DATABASE testDB
GO

#创建数据库(指定文件路径)
CREATE DATABASE test2 
ON PRIMARY (NAME = N'test2_Data',FILENAME = N'/data/test2_Data.MDF' ,FILEGROWTH = 10%) 
LOG ON ( NAME =N'test2_Log',FILENAME = N'/data/test2_Log.LDF' ,FILEGROWTH = 10%)
GO


  

 