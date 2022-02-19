# nextcloud优化


#--------------------------------------------------------------------
# NextCloud终极优化，内网上传破100M/s优化)
> https://blog.csdn.net/qq_28718329/article/details/112687699
> https://blog.qiquanji.com/post/291.html

#上传速度优化（解除块大小限制，-u参数按需修改）
docker exec -u 33 -it nextcloud bash
php occ config:app:set files max_chunk_size --value 0


#--------------------------------------------------------------------
# Nextcloud信任所有域名地址
> https://www.h5av.com/archives/191.html

#config.php
'trusted_domains' => array(
        0 => '127.0.0.1',
        1 => preg_match('/cli/i',php_sapi_name())?'127.0.0.1':$_SERVER['SERVER_NAME'],
),



#--------------------------------------------------------------------
# 指定重定向域名

#修改文件 nextcloud/html/config/config.php
  'overwritehost' => 'pan.sers.cloud:6106',
  'overwriteprotocol' => 'https',


#--------------------------------------------------------------------
# Nextcloud自动清理回收站
> https://blog.csdn.net/weixin_43598457/article/details/117367623

# 手动清空所有用户的回收站
docker exec -u 33 -it nextcloud bash
php occ trashbin:cleanup --all-users

#3天自动清理一次所有用户的回收站
> 修改文件 nextcloud/html/config/config.php 添加如下配置
'trashbin_retention_obligation' => 'auto,3',

#--------------------------------------------------------------------
# 离线安装应用
> https://www.himstudy.net/%E6%89%8B%E5%8A%A8%E7%A6%BB%E7%BA%BF%E5%AE%89%E8%A3%85nextcloud%E5%BA%94%E7%94%A8/

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
# OCC命令给ownCloud/Nextcloud手动添加文件
> https://www.orgleaf.com/2400.html


#建立软链接
mkdir -p /root/nextcloud/nextcloud/html/data/lith/files/王志雷-娱乐 

ln -s /media/root/D3王志雷-娱乐 /root/nextcloud/nextcloud/html/data/lith/files/王志雷-娱乐 

#删除软链接
rm -rf /root/nextcloud/nextcloud/html/data/lith/files/王志雷-娱乐 



docker exec -u www-data -it nextcloud bash

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

apt-get update

#安装
apt-get install ffmpeg -y

#查看版本 
ffmpeg -version


#--------------------------------------------------------------------
# [无效]支持avi文件在线播放
# https://www.cnblogs.com/puxi/p/10319599.html

docker exec -it nextcloud bash

# 1修改文件
apps/files_videoplayer/js/main.js

# 2搜索mimeType
# 添加两行代码，加入对avi文件的支持。如下：
mimeTypes : ['video/x-msvideo']
mimeTypeAliasses: {'video/x-matroska': 'video/webm' ,'video/x-msvideo': 'video/mp4','video/quicktime': 'video/mp4' }

# 3保存,刷新浏览器缓存即可。

 



#--------------------------------------------------------------------
# 离线下载
 https://www.jianshu.com/p/c03ca24a6650

# (x.1)nextcloud应用启用ocdownload

# (x.2)安装aria2
docker exec -it nextcloud bash

apt-get update
apt-get install aria2 -y
aria2c --enable-rpc --rpc-allow-origin-all -c -D --check-certificate=false


#手动启动aria2
> 每次重启后需要手动启动
docker exec -it nextcloud aria2c --enable-rpc --rpc-allow-origin-all -c -D --check-certificate=false

#多线程分段下载
docker exec -it nextcloud aria2c --enable-rpc --rpc-allow-origin-all -s 20 -x 4 -j 10 -c -D --check-certificate=false


-D 后台运行（守护进程）

--s, --split=N 使用N个连接下载文件。如果提供了超过N个URL，使用前N个URL而剩下的URL作为备用。
如果提供了少于N个URL，这些URL将会被重复使用来使这N个连接能够同时建立。
对相同主机的连接数被--max-connection-per-server选项所限制。
另见--min-split-size选项。
可能的取值： 1-* 。默认： 5

-x, --max-connection-per-server=NUM The maximum number of connections to one server for each download.
可能的取值： 1-16。默认： 1 

-j, --max-concurrent-downloads=N
设置同时下载的文件数 1-* 默认5

-c, --continue[=true|false]
断点续传


-d, --dir=DIR
下载到哪个目录
类似: D:\

-i, --input-file=FILE
批量下载文本中所有URL
比如aria2c -i uris.txt

-o, --out=FILE
下载保存的文件名

