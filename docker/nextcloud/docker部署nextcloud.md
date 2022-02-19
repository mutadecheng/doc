# docker部署
> 私人网盘nextcloud

https://hub.docker.com/_/nextcloud

https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/reverse_proxy_configuration.html#multiple-domains-reverse-ssl-proxy

https://blog.csdn.net/jiayoubing/article/details/106112477

Nextcloud反向代理的相关配置说明
https://www.orgleaf.com/3200.html

软件下载
https://download.nextcloud.com/

# 创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
 
#查看容器logs
docker logs nextcloud

#停止容器
docker stop nextcloud

#打开容器
docker start nextcloud

#重启容器
docker restart nextcloud

#删除容器
docker rm nextcloud -f
docker rm nextcloud-mysql -f

#进入容器执行命令
docker exec -it nextcloud bash




#--------------------------------------------------------------------
#(x.1)部署数据库

mkdir -p /root/docker/nextcloud

basePath=/root/docker/nextcloud
docker run --restart=always -d \
--name nextcloud-mysql \
-v /etc/localtime:/etc/localtime \
-v $basePath/mysql/conf.d:/etc/mysql/conf.d \
-v $basePath/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql:8.0.25


#限制内存(按需)
--performance_schema_max_table_instances=100 \
--table_definition_cache=32 \
--table_open_cache=32 \
--performance_schema=off


#启用远程连接(按需)
docker exec -it nextcloud-mysql bash
mysql -u root -p123456
use mysql;
update user set host='%' where user='root';
flush privileges;


#--------------------------------------------------------------------
#(x.2)docker部署nextcloud

#部署（使用mysql）
cd /root/docker/nextcloud
docker run --restart=always -d \
--name=nextcloud \
--link nextcloud-mysql:mysql \
--add-host onlyoffice.lith.cloud:192.168.20.20 \
-p 2060:80 \
-v $PWD/nextcloud/html:/var/www/html \
nextcloud:22.2.0


docker rm nextcloud -f


--add-host onlyoffice.lith.cloud:192.168.20.20 \
--link nextcloud-onlyoffice:onlyoffice.lith.cloud \

#管理页面
http://ip:2060


配置文件： nextcloud/nextcloud/html/config/config.php

mysql配置
账号: root/123456
数据库名: nextcloud
host: mysql


#--------------------------------------------------------------------
#部署（无数据库）
docker run --restart=always -d \
--name=nextcloud \
-p 2003:80 \
-v $basePath/nextcloud/html:/var/www/html \
nextcloud:22.2.0

see
-v $PWD/apps:/var/www/html/custom_apps \
-v $PWD/config:/var/www/html/config \
-v $PWD/data:/var/www/html/data \
-v $PWD/theme:/var/www/html/themes \


 
#精简部署
docker run --name=nextcloud --restart=always -d -p 6190:80 nextcloud
# 管理页面 http://ip:6190



#--------------------------------------------------------------------
# Error when trying to connect (Host violates local access rules)
https://blog.csdn.net/qq_24413521/article/details/107205564

config.php配置文件添加配置
'allow_local_remote_servers' => true,



文件目录 (/volume1/web/owncloud/data) 可以被其他用户读取请更改权限为 0770 以避免其他用户查看目录。
config.php添加
'check_data_directory_permissions' => false,



