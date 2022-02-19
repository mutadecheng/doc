# docker部署ftp服务器

# 1.创建文件夹
> 创建文件目标文件夹,把部署文件拷贝进去  
``` bash
mkdir -p /root/docker/ftp
```

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash
# 指定宿主机ip地址
# serverIp=$(ping -c 2 ali.sers.cloud | head -2 | tail -1 | awk '{print $5}' | sed 's/[(:)]//g')
#serverIp=$(curl ifconfig.me)
serverIp=127.0.0.1
echo $serverIp

# 创建容器-指定账号
cd /root/docker/ftp
docker run --name ftp --restart=always -d \
-p 20:20 -p 21:21 -p 21100-21110:21100-21110 \
-v $PWD/data:/home/vsftpd \
-e FTP_USER=lith \
-e FTP_PASS=Admin0123 \
-e PASV_ADDRESS=$serverIp \
-e PASV_MIN_PORT=21100 \
-e PASV_MAX_PORT=21110 \
saved/ftp


# 创建容器-不指定账号
cd /root/docker/ftp
docker run --name ftp --restart=always -d \
-p 20:20 -p 21:21 -p 21100-21110:21100-21110 \
-v $PWD/data:/home/vsftpd \
-e PASV_ADDRESS=$serverIp \
-e PASV_MIN_PORT=21100 \
-e PASV_MAX_PORT=21110 \
saved/ftp

# 添加文件夹读权限
chmod 777  -R /root/docker/ftp/data

# 访问地址
ftp://lith:Admin012@ip:20  
ftp://ip  

# 命令行下载文件
cd /root/docker/ftp
curl -o file.mp4 http://www.linux.com/file.mp4
```



# 3.容器常用命令

``` bash
#查看容器logs
docker logs ftp

#停止容器
docker stop ftp

#打开容器
docker start ftp

#重启容器
docker restart ftp

#删除容器
docker rm ftp -f

#进入容器执行命令
docker exec -it ftp /bin/sh
```



# 4.其他
> copy from fauria/vsftpd，故文中的镜像地址 saved/ftp 亦可改为 fauria/vsftpd  
> 参见 https://hub.docker.com/r/fauria/vsftpd  
> 参考 https://www.jianshu.com/p/c84f6e6de002  

``` bash
# 备份docker镜像
# docker login -u saved -p xxx
docker pull fauria/vsftpd
docker tag fauria/vsftpd saved/ftp
docker push saved/ftp
```