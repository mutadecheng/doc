# docker部署rtorrent-rutorrent
> https://www.moerats.com/archives/673/ 


# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

``` bash

mkdir -p /root/docker/rtorrent/down

cd /root/docker/rtorrent

#(x.1)创建配置文件.htpasswd(不需要密码访问可跳过)
#以下3种加密任选其一（用户名为lith,密码为Admin0123,按需修改）
#crypt加密
printf "lith:$(openssl passwd -crypt Admin0123)\n" >> ./down/.htpasswd 

#apr1加密
printf "lith:$(openssl passwd -apr1 Admin0123)\n" >> ./down/.htpasswd 

#MD5加密
printf "lith:$(openssl passwd -1 Admin0123)\n" >> ./down/.htpasswd 





 
#(x.2)创建容器
docker run --name rtorrent --restart=always -d \
-p 8080:80 -p 49160:49160/udp -p 49161:49161 \
-v $PWD/down:/downloads \
diameter/rtorrent-rutorrent



#访问地址
http://192.168.56.114:8080


#建议下载BT的时候安装BBR或者锐速进行加速

```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs rtorrent

#停止容器
docker stop rtorrent

#打开容器
docker start rtorrent

#重启容器
docker restart rtorrent

#删除容器
docker rm rtorrent -f


#进入容器执行命令
docker exec -it rtorrent bash


```


 






