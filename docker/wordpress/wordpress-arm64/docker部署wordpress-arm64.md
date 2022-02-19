# docker部署
> WordPress
https://www.yisu.com/zixun/158968.html
https://hub.docker.com/_/wordpress


# 创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
 
#查看容器logs
docker logs wordpress

#停止容器
docker stop wordpress
docker stop wordpress_mysql

#打开容器
docker start wordpress_mysql
docker start wordpress

#重启容器
docker restart wordpress

#删除容器
docker rm wordpress -f
docker rm wordpress_mysql -f

#进入容器执行命令
docker exec -it wordpress bash


#docker备份文件
zip -r /root/backup/wordpress/wordpress-sers_$(date +"%Y-%m-%d_%H%M").zip /root/docker/wordpress

cd /root/docker
zip -r wordpress-sers.zip wordpress

#docker还原文件
cd /root/docker
unzip wordpress-sers.zip -d wordpress



#--------------------------------------------------------------------

#(x.1)部署数据库
cd /root/docker/wordpress/mysql
docker run --restart=always -d \
--name wordpress-mysql \
-v /etc/localtime:/etc/localtime \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql/mysql-server:8.0

#开放端口参数 -p 6194:3306 \


# (x.x.1)进入容器执行命令
docker exec -it wordpress-mysql bash
mysql -u root -p123456

# (x.x.2)启用远程连接
use mysql;
update user set host='%' where user='root';
flush privileges;

### (x.x.3)避免datetime类型默认值出现“Invalid default value for..."错误
-- 查看sql_mode
show variables like '%sql_mode%';

-- 修改sql_mode,去掉NO_ZERO_IN_DATE,NO_ZERO_DATE:
set sql_mode='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
set global sql_mode='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';




### (x.x.5)退出
exit
exit

 


#(x.2)强制还原数据库
docker run --rm -it \
--link wordpress-mysql:mysql \
-v /root/docker/wordpress:/root/docker/wordpress  \
serset/sqler  \
dotnet Sqler.dll MySql.Restore \
-f --filePath "/root/docker/wordpress/wordpress.sqler.zip" \
--ConnectionString "Data Source=mysql;Port=3306;Database=wordpress;User Id=root;Password=123456;CharSet=utf8;Convert Zero Datetime=True;Allow Zero Datetime=True;"
 




### (x.3)修改域名
# (x.x.1)进入容器执行命令
docker exec -it wordpress-mysql bash
mysql -u root -p123456
# (x.x.2)修改域名
use wordpress;
update wp_options set option_value='http://doc.sers.cloud' where option_name in ('siteurl','home');







#--------------------------------------------------------------------
#(x.4)部署WordPress

cd /root/docker/wordpress/wordpress
docker run --restart=always -d \
--name wordpress \
-p 80:80 \
--link wordpress-mysql:mysql \
-v $PWD/wp-content:/var/www/html/wp-content \
-e WORDPRESS_WPLANG=zh-CN \
-e WORDPRESS_DB_HOST=mysql \
-e WORDPRESS_DB_USER=root \
-e WORDPRESS_DB_PASSWORD=123456 \
-e WORDPRESS_DB_NAME=wordpress \
wordpress



-v $PWD/plugins:/var/www/html/wp-content/plugins \
-v $PWD/themes:/var/www/html/wp-content/themes \
-v $PWD/upgrade:/var/www/html/wp-content/upgrade \
-v $PWD/uploads:/var/www/html/wp-content/uploads \

cache  index.php  languages  plugins  themes  upgrade  uploads
 


#部署WordPress-精简
cd /root/docker/wordpress/wordpress
docker run --restart=always -d \
--name wordpress \
-p 80:80 \
--link wordpress_mysql:mysql \
wordpress



http://192.168.0.153

登陆地址：
http://192.168.0.153/wp-login.php

http://192.168.0.153/wp-admin/setup-config.php



# 主题

启用主题 Sparkling

Ignite  
	Layout		: Left sidebar
	Background	: #1e73be

PressBook

# 插件
WP Editor.md
WP Import Export Lite


# 导入
WordPress


#----------------------------------------------
nginx给wordpress反向代理
https://blog.csdn.net/dante_003/article/details/54930925


#1.配置nginx

server_name www.xxx.com blog.xxx.com;

location / {
 proxy_pass http://localhost:81/blog/;
 proxy_set_header Host $host;
}

#2.修改wp-config.php，加入如下
define('WP_HOME', 'http://'.$_SERVER['HTTP_HOST'].'/blog');
define('WP_SITEURL', 'http://'.$_SERVER['HTTP_HOST'].'/blog');









#-------------------------------------------------------------------------------

#备份数据库
docker run --rm -it \
--link wordpress-mysql:mysql \
-v /root/docker/wordpress:/root/docker/wordpress  \
serset/sqler  \
dotnet Sqler.dll MySql.BackupSqler \
--filePath "/root/docker/wordpress/wordpress.sqler-2.zip" \
--ConnectionString "Data Source=mysql;Port=3306;Database=wordpress;User Id=root;Password=123456;CharSet=utf8;Convert Zero Datetime=True;Allow Zero Datetime=True;"
 


