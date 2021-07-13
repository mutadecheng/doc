# docker部署svn-client
 
# 1.创建文件夹
> 创建目标文件夹/root/docker/svn-client,把部署文件拷贝进去
 


# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

``` bash

 
#精简
cd /root/docker/svn-client
docker run --name=svn-client --restart=always -d \
-v $PWD/svn:/root/svn \
serset/svn-client


#创建临时容器
docker run -it --rm -v /root/temp/svn/code:/root/svn serset/svn-client bash

 

#直接执行 checkout
docker run -it --rm -v /root/temp/svn/code:/root/svn serset/svn-client \
svn checkout "svn://192.168.1.45:6197/智能事业部/CIM底座/4.数据汇聚" /root/svn \
--username wangzhilei \
--password wangzhilei123456 \
--no-auth-cache


#直接执行 revert
docker run -it --rm -v /root/temp/svn/code:/root/svn serset/svn-client \
svn revert /root/svn -R  
 
 

#直接执行 update
docker run -it --rm -v /root/temp/svn/code:/root/svn serset/svn-client \
svn update /root/svn \
--username wangzhilei \
--password wangzhilei123456 \
--no-auth-cache 
 

```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs svn-client

#停止容器
docker stop svn-client

#打开容器
docker start svn-client

#重启容器
docker restart svn-client

#删除容器
docker rm svn-client -f


#进入容器执行命令
docker  exec -it svn-client bash


#创建临时容器
docker run -it --rm serset/svn-client bash

```


 






