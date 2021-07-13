# docker部署
> WordPress
https://www.yisu.com/zixun/158968.html
https://hub.docker.com/_/wordpress


export bashPath=/root/NextCloud/lith/wordpress

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
docker stop wordpress-mysql

#打开容器
docker start wordpress-mysql
docker start wordpress

#重启容器
docker restart wordpress

#删除容器
docker rm wordpress -f
docker rm wordpress-mysql -f

#进入容器执行命令
docker  exec -it wordpress bash


#docker备份文件
zip -r /root/backup/wordpress/wordpress-sers_$(date +"%Y-%m-%d_%H%M").zip /root/docker/wordpress

cd /root/docker
zip -r wordpress-sers.zip wordpress

#docker还原文件
cd /root/docker
unzip wordpress-sers.zip -d wordpress



docker cp wordpress:/var/www/html/wp-content /root/docker/wordpress/temp

#--------------------------------------------------------------------
#(x.1)部署数据库

cd ${bashPath}/mysql
chmod 644 -R conf.d
chmod 777 -R data

cd ${bashPath}/mysql
docker run --restart=always -d \
--name wordpress-mysql \
-v /etc/localtime:/etc/localtime \
-v $PWD/conf.d:/etc/mysql/conf.d \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql:8.0.25 


#部署数据库-限制内存
cd ${bashPath}/mysql
docker run --restart=always -d \
--name wordpress-mysql \
-v /etc/localtime:/etc/localtime \
-v $PWD/conf.d:/etc/mysql/conf.d \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql:8.0.25  \
--performance_schema_max_table_instances=100 \
--table_definition_cache=32 \
--table_open_cache=32 \
--performance_schema=off

#部署数据库-开放端口
cd ${bashPath}/mysql
docker run --restart=always -d \
--name wordpress-mysql \
-p 6194:3306 \
-v /etc/localtime:/etc/localtime \
-v $PWD/conf.d:/etc/mysql/conf.d \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql:8.0.25 

#--------------------------------------------------------------------
#(x.2)部署WordPress

cd ${bashPath}/wordpress
docker run --restart=always -d \
--name wordpress \
-p 6193:80 \
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
cd ${bashPath}/wordpress
docker run --restart=always -d \
--name wordpress \
-p 6193:80 \
--link wordpress-mysql:mysql \
wordpress



http://doc.sers.cloud:6193

登陆地址：
http://doc.sers.cloud:6193/wp-login.php

http://doc.sers.cloud:6193/wp-admin/setup-config.php



# 主题
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
# mysql修改域名
docker  exec -it wordpress-mysql bash

mysql -u root -p123456

use wordpress;
update `wp_options` set  option_value='http://doc.sers.cloud:6100' where option_name='siteurl' or  option_name='home';
-- update `wp_users` set  user_url='http://doc.sers.cloud:6100';


#----------------------------------------------
nginx给wordpress反向代理
https://blog.csdn.net/dante_003/article/details/54930925


#1.配置nginx

server_name www.xxx.com blog.xxx.com;

location / {
	#proxy_set_header Host $host;
	proxy_set_header Host doc.sers.cloud:6100;
	proxy_pass http://127.0.0.1:6193;
}


#无需以下操作
#2.修改/var/www/html/wp-config.php，加入如下
define('WP_HOME', 'http://'.$_SERVER['HTTP_HOST'].'/blog');
define('WP_SITEURL', 'http://'.$_SERVER['HTTP_HOST'].'/blog');
#或直接改为如下
define('WP_SITEURL', 'http://doc.sers.cloud:6100');  
define('WP_HOME', 'http://doc.sers.cloud:6100');  



