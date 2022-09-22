# docker部署samba
> https://www.cnblogs.com/xiwang/p/10496661.html
> https://hub.docker.com/r/dperson/samba


# 1.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  


``` bash

# -s "<name;/path>[;browse;readonly;guest;users;admins;writelist;comment]"

# 创建容器-指定账号
mkdir -p /root/docker/samba/data
cd /root/docker/samba
docker run --name samba --restart=always -d \
-p 139:139 -p 445:445 \
-v $PWD/data:/mount \
saved/samba \
-u "lith;Admin0123" \
-s "fold1;/mount/;yes;no;no;all;lith;lith"


# 访问地址
\\192.168.56.113\fold1



# 3.容器常用命令

``` bash
#查看容器logs
docker logs samba

#停止容器
docker stop samba

#打开容器
docker start samba

#重启容器
docker restart samba

#删除容器
docker rm samba -f

#进入容器执行命令
docker exec -it samba /bin/sh
```



# 4.其他
> copy from dperson/samba，故文中的镜像地址 saved/samba 亦可改为 dperson/samba  
``` bash
# 备份docker镜像
# docker login -u saved -p xxx
docker pull dperson/samba
docker tag dperson/samba saved/samba
docker push saved/samba
```