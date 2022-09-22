# docker部署
> https://blog.whsir.com/post-2809.html
> 跨平台（含树莓派）镜像为 ixdotai/openvpn:0.2.3
> 最初的镜像为 kylemanna/openvpn:2.4


# 1.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash


#创建OpenVPN服务
cd /root/docker/openvpn
docker run --name openvpn -v $PWD:/etc/openvpn -v /etc/localtime:/etc/localtime -d -p 1194:1194/tcp --cap-add=NET_ADMIN ixdotai/openvpn:0.2.3





#-------------------
#初始化配置
	
mkdir -p /root/docker/openvpn/conf
cd /root/docker/openvpn


#生成配置文件(ip改为服务器的ip或域名)
docker run -v $PWD:/etc/openvpn --rm ixdotai/openvpn:0.2.3 ovpn_genconfig -u tcp://47.47.47.47
 
#生成密钥文件
docker run -v $PWD:/etc/openvpn --rm -it ixdotai/openvpn:0.2.3 ovpn_initpki


#生成客户端证书（lith改成你想要的名字）
docker run -v $PWD:/etc/openvpn --rm -it ixdotai/openvpn:0.2.3 easyrsa build-client-full lith nopass

#导出客户端配置
docker run -v $PWD:/etc/openvpn --rm ixdotai/openvpn:0.2.3 ovpn_getclient lith > $PWD/conf/lith.ovpn



#-------------------

#客户端使用conf/lith.ovpn文件连接
> 若改变了docker对外端口号，客户端连接前先修改ovpn文件中的端口1194为映射的端口
> 客户端要和服务端时间一致，否则无法连接成功
 
#创建用户
bash /root/docker/openvpn/conf/add.bash

#删除用户
bash /root/docker/openvpn/conf/delete.bash


``` 



#-----------------------------------------
# 2.容器常用命令

``` bash


#查看openvpn日志
docker exec -it openvpn cat /tmp/openvpn-status.log


#查看容器logs
docker logs openvpn

#停止容器
docker stop openvpn

#打开容器
docker start openvpn

#重启容器
docker restart openvpn

#删除容器
docker rm openvpn -f

#进入容器执行命令
docker exec -it openvpn bash


```



#-----------------------------------------
# 错误解决

# iptables v1.8.6 (legacy): can't initialize iptables table `nat': Table does not exist (do you need to insmod?)
> Perhaps iptables or your kernel needs to be upgraded.
#原因：iptables 没有启动，可通过如下命令启动
modprobe ip_tables;



#解决客户端dns无法解析的问题
>修改文件openvpn.conf，注释如下两行，然后重启即可
# push "dhcp-option DNS 9.9.9.11"
# push "dhcp-option DNS 149.112.112.11"








