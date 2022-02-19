# docker部署wordpress
> https://www.yisu.com/zixun/158968.html
> https://hub.docker.com/_/wordpress


# 创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
 
#查看容器logs
docker logs wordpress-mysql
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
docker exec -it wordpress bash



cd /root/docker/wordpress/mysql
chmod 644 -R conf.d
chmod 777 -R data

#--------------------------------------------------------------------
#(x.1)部署数据库

cd /root/docker/wordpress/mysql
docker run --restart=always -d \
--name wordpress-mysql \
-v /etc/localtime:/etc/localtime \
-v $PWD/conf.d:/etc/mysql/conf.d \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql:8.0.25

#创建数据库
docker exec -it wordpress-mysql bash
mysql -u root -p123456
create database wordpress;
exit
exit





## 限制内存
mysql:8.0.25 \
--performance_schema_max_table_instances=100 \
--table_definition_cache=32 \
--table_open_cache=32 \
--performance_schema=off


## 开放端口
-p 6194:3306 \


#--------------------------------------------------------------------
#(x.2)部署wordpress
cd /root/docker/wordpress/wordpress
unzip html.zip -d ./
rm -f html.zip


cd /root/docker/wordpress/wordpress
docker run --restart=always -d \
--name wordpress \
--link wordpress-mysql:mysql \
-p 6193:80 \
-v $PWD/html:/var/www/html \
-e WORDPRESS_WPLANG=zh-CN \
-e WORDPRESS_DB_HOST=mysql \
-e WORDPRESS_DB_USER=root \
-e WORDPRESS_DB_PASSWORD=123456 \
-e WORDPRESS_DB_NAME=wordpress \
wordpress:php7.4



#登陆地址：

http://192.168.20.20:6193

http://192.168.20.20:6193/wp-login.php

http://192.168.20.20:6193/wp-admin/setup-config.php






#精简部署wordpress
cd /root/docker/wordpress/wordpress
docker run --restart=always -d \
--name wordpress \
--link wordpress-mysql:mysql \
-p 6193:80 \
wordpress:php7.4

 