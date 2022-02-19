# docker部署
> TURN
https://www.freesion.com/article/4327832859/
https://github.com/konoui/kurento-coturn-docker.git


# 创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
 
docker rm coturn -f

docker run --restart=always -d \
-u root --privileged=true \
--name coturn \
-p 2004:3478 -p 2004:3478/udp \
-v /etc/localtime:/etc/localtime \
serset/coturn


docker logs coturn


#测试stun和turn的有效性：
https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/


turn:home.lith.cloud:2004
用户名和密码都是kurento

点击 Gather candidates 。成功会显示“done”,不成功一般会说“auth failed”或者“not reachable？”


