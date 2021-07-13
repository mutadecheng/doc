# docker部署svn服务器

# 1.创建文件夹
``` bash
mkdir -p /root/docker/svn/data
```

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash
# 创建容器
cd /root/docker/svn
docker run --name svn --restart always -d \
-p 3690:3690 \
-v /etc/localtime:/etc/localtime \
-v $PWD/data:/var/opt/svn \
saved/svn
```

# 3.svn命令
``` bash
#(x.1)创建资源库(库名为 repo)
docker  exec -it svn /bin/sh
svnadmin create repo

#(x.2)资源库配置
#文件夹：/root/docker/svn/data/repo/conf

#(x.x.1)passwd（密码文件）
#设置用户密码，增加账户 lith密码为123456:
[users]
lith = 123456

#(x.x.2)authz（授权文件）
#直接给用户设置权限
[/]
lith = rw

#(x.x.3)svnserve.conf
#[general]
anon-access = none
auth-access = write
password-db = passwd
authz-db = authz

# 使非授权用户无法访问
# 使授权用户有写权限
# 指明密码文件路径
# 访问控制文件


#(x.3)重启容器
docker restart svn

#客户端连接测试 svn://ip:3690/repo，注意开启防火墙端口3690
svn://192.168.56.105:3690/repo

 
#(x.4)备份与还原
docker  exec -it svn /bin/sh

#备份
svnadmin dump /var/opt/svn/repo > /var/opt/svn/repo.svn.bak
#还原
svnadmin load repo < /var/opt/svn/repo.svn.bak
```


# 4.容器常用命令
``` bash
#查看容器logs
docker logs svn

#停止容器
docker stop svn

#打开容器
docker start svn

#重启容器
docker restart svn

#删除容器
docker rm svn -f

#进入容器执行命令
docker  exec -it svn /bin/sh
```


# 4.其他
> copy from garethflowers/svn-server，故文中的镜像地址 saved/svn 亦可改为 garethflowers/svn-server:1.3.1  
> 参见 https://hub.docker.com/r/garethflowers/svn-server  
> 参考 https://blog.csdn.net/xu12387/article/details/93050196

``` bash
# 备份docker镜像
# docker login -u saved -p xxx
docker pull garethflowers/svn-server:1.3.1
docker tag garethflowers/svn-server:1.3.1 saved/svn
docker push saved/svn
docker tag garethflowers/svn-server:1.3.1 saved/svn:1.3.1
docker push saved/svn:1.3.1
```