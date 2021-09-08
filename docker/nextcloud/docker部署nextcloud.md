# docker部署
> 私人网盘nextcloud

https://hub.docker.com/_/nextcloud

https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/reverse_proxy_configuration.html#multiple-domains-reverse-ssl-proxy

https://blog.csdn.net/jiayoubing/article/details/106112477

Nextcloud反向代理的相关配置说明
https://www.orgleaf.com/3200.html


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
docker  exec -it nextcloud bash




#--------------------------------------------------------------------
#(x.1)部署数据库

basePath=/root/docker/nextcloud
basePath=/root/NextCloud/nextcloud

docker run --restart=always -d \
--name nextcloud-mysql \
-v /etc/localtime:/etc/localtime \
-v $basePath/mysql/conf.d:/etc/mysql/conf.d \
-v $basePath/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql:8.0.25 \
--performance_schema_max_table_instances=100 \
--table_definition_cache=32 \
--table_open_cache=32 \
--performance_schema=off



-p 61900:3306 \





#--------------------------------------------------------------------
#(x.2)docker部署nextcloud

#部署（无数据库）
docker run --restart=always -d \
--name=nextcloud \
-p 6190:80 \
-v $basePath/nextcloud/html:/var/www/html \
nextcloud:21.0.1




#部署（使用mysql）
docker run --restart=always -d \
--name=nextcloud \
--link nextcloud-mysql:mysql \
-p 6190:80 \
-v $basePath/nextcloud/html:/var/www/html \
nextcloud:21.0.1


see
-v $PWD/apps:/var/www/html/custom_apps \
-v $PWD/config:/var/www/html/config \
-v $PWD/data:/var/www/html/data \
-v $PWD/theme:/var/www/html/themes \

#管理页面
https://pan.sers.cloud:6191


配置文件： nextcloud/nextcloud/html/config/config.php

mysql配置
host: mysql
账号: root/123456
数据库名: nextcloud


 
#精简部署
docker run --name=nextcloud --restart=always -d -p 6190:80 nextcloud
# 管理页面 http://ip:6190





#--------------------------------------------------------------------
# 修改mysql域名

修改文件 nextcloud/html/config/config.php

  'overwritehost' => 'pan.sers.cloud:6106',
  'overwriteprotocol' => 'https',




#--------------------------------------------------------------------
# 离线安装应用
 https://www.himstudy.net/%E6%89%8B%E5%8A%A8%E7%A6%BB%E7%BA%BF%E5%AE%89%E8%A3%85nextcloud%E5%BA%94%E7%94%A8/

# (x.1)去应用商店下载应用
# https://apps.nextcloud.com/

#(x.2)拷贝安装包到目录custom_apps

#(x.3)解压安装包
cd /root/docker/nextcloud/nextcloud/html/custom_apps
tar -zxvf spreed-5.0.4.tar.gz

#(x.4)赋予所有权
chmod 777 -R spreed


chmod 777 -R /root/docker/nextcloud/nextcloud/html/custom_apps



#--------------------------------------------------------------------
Error when trying to connect (Host violates local access rules)
https://blog.csdn.net/qq_24413521/article/details/107205564

config.php配置文件添加配置
'allow_local_remote_servers' => true,




文件目录 (/volume1/web/owncloud/data) 可以被其他用户读取请更改权限为 0770 以避免其他用户查看目录。
config.php添加
'check_data_directory_permissions' => false,






#--------------------------------------------------------------------
OCC命令给ownCloud/Nextcloud手动添加文件
https://www.orgleaf.com/2400.html



#建立软链接
mkdir -p /root/nextcloud/nextcloud/html/data/lith/files/王志雷-娱乐 

ln -s /media/root/D3王志雷-娱乐 /root/nextcloud/nextcloud/html/data/lith/files/王志雷-娱乐 

#删除软链接
rm -rf /root/nextcloud/nextcloud/html/data/lith/files/王志雷-娱乐 



docker  exec -u www-data -it nextcloud bash

#扫描所有用户的所有文件
php occ files:scan --all 

#列出所有用户
php occ user:list


#为用户lith扫描文件
php occ files:scan lith

#扫描用户lith的Photos文件夹
php occ files:scan --path="/lith/files"


#--------------------------------------------------------------------
#安装FFmpeg

docker exec -it nextcloud bash

#安装
apt-get install ffmpeg

#查看版本 
ffmpeg -version


#--------------------------------------------------------------------
#支持avi文件在线播放
# https://www.cnblogs.com/puxi/p/10319599.html

docker exec -it nextcloud bash

# 1修改文件
apps/files_videoplayer/js/main.js

# 2搜索mimeType
# 添加两行代码，加入对avi文件的支持。如下：
mimeTypes : ['video/x-msvideo']
mimeTypeAliasses: {'video/x-matroska': 'video/webm' ,'video/x-msvideo': 'video/mp4','video/quicktime': 'video/mp4' }

# 3保存,刷新浏览器缓存即可。








