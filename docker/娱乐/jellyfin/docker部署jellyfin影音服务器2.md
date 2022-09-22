# docker部署jellyfin影音服务器
> https://zhuanlan.zhihu.com/p/448769048
> https://post.smzdm.com/p/ad28lg6d/ Jellyfin一个免费无广告的私人影视APP
> https://jellyfin.org/posts/android-v2.3.0/
> https://repo.jellyfin.org/releases/client/android/ android app

# 1.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash

mkdir -p /root/docker/jellyfin/media


docker rm jellyfin -f


cd /root/docker/jellyfin
docker run --name=jellyfin --restart=always -d \
-p 8096:8096 \
-v $PWD/media:/media:ro \
-v $PWD/config:/config \
-v $PWD/cache:/cache \
-v $PWD/fonts:/usr/share/fonts/truetype/dejavu \
--device=/dev/dri \
-e PUID=0 \
-e PGID=0 \
-e TZ=Asia/Shanghai \
nyanmisaka/jellyfin



-v /srv/dev-disk-by-uuid-0001043F0004DD59/movie:/media:ro \
-v $PWD/media:/media:ro \





```


http://192.168.0.153:8096


# 3.容器常用命令

``` bash
#查看容器logs
docker logs jellyfin

#停止容器
docker stop jellyfin

#打开容器
docker start jellyfin

#重启容器
docker restart jellyfin

#删除容器
docker rm jellyfin -f


#进入容器执行命令
docker exec -it jellyfin bash

```




#------------------------------
#硬件解码
设置 服务器 播放 转码 
   硬件加速  Video Acceleration API(VAAPI)
   VA-API 设备 /dev/dri/renderD128



#----------------
#显示乱码（字幕、文件名方框）
> https://post.smzdm.com/p/ad28lg6d/

#1.找到一个中文字体，（路径在C:\Windows\Fonts），复制6份，命名如下：
DejaVuSans.ttf
DejaVuSans-Bold.ttf
DejaVuSansMono.ttf
DejaVuSansMono-Bold.ttf
DejaVuSerif.ttf
DejaVuSerif-Bold.ttf

#2.复制到font文件夹并映射到容器
-v $PWD/fonts:/usr/share/fonts/truetype/dejavu \

#3.解决字幕方框
jellyfin控制台-播放
	备用字体文件路径 /usr/share/fonts/truetype/dejavu
	启用备用字体 勾选
然后保存即可


