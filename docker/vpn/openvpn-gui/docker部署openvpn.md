# docker部署
> https://lemonbk.com/archives/35/
> https://openvpn.net/download-open-vpn/
> http://www.178linux.com/74524

# 1.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash

docker rm -f openvpn-gui
 
docker rm -f openvpn
 

# 创建容器
mkdir -p /root/docker/vpn
cd /root/docker/vpn

docker run --restart=always -d --privileged \
--name openvpn-gui \
-p 8080:8080 \
-v $PWD/conf:/etc/openvpn \
-v $PWD/db:/opt/openvpn-gui/db \
dockerlemon/lemon_openvpn-web



docker run --restart=always -d --privileged \
--name openvpn \
--net=host \
-v $PWD/conf:/etc/openvpn \
dockerlemon/lemon_openvpn:v1.0

-p 1194:1194/udp \


http://ip:8080
#username: admin
#password: b3secure

47.241.23.148

到Configuration的Settings里将ip改为服务器的外网ip并更新,然后到certificates里添加用户后，
点击用户名下载配置文件，解压后修改conf文件后缀为ovpn就可以了


``` 


# 2.容器常用命令

``` bash
#查看容器logs
docker logs vpn

#停止容器
docker stop vpn

#打开容器
docker start vpn

#重启容器
docker restart vpn

#删除容器
docker rm vpn -f

#进入容器执行命令
docker exec -it vpn bash
```


