# docker部署ss
> https://hub.docker.com/r/shadowsocks/shadowsocks-libev
> http://fhaoer.com/20190617-shadowsocks-libev/

# 1.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

> ss参数:
> -e PASSWORD=密码
> -e SERVER_PORT=端口 默认8388
> -e METHOD=加密方式 默认aes-256-gcm
> -e TIMEOUT=超时时间 默认300
> -e DNS_ADDRS=dns地址 默认8.8.8.8,8.8.4.4

 

# 创建容器 
docker run -d --name=tinyproxy -p 3128:3128 minimum2scp/squid

 
docker run -d --name=tinyproxy -p 3128:8888 endoffight/tinyproxy ANY
docker run -d --name=tinyproxy -p 3128:8888 monokal/tinyproxy ANY
docker run -d --name=tinyproxy -p 3128:8888 stilleshan/tinyproxy ANY
docker run -d --name=tinyproxy -p 3128:3128 sameersbn/squid:3.3.8-14 ANY




# 创建临时容器
docker run --rm -it -p 3128:3128 minimum2scp/squid



 
 docker run -d --name=tinyproxy --net=host minimum2scp/squid
----------------------
docker rm tinyproxy -f
docker logs tinyproxy



ss.lith.cloud:3129


 
curl -x https://ss.lith.cloud:8888 cip.cc


curl -x http://ss.lith.cloud:6666 https://www.google.com

curl -x ss.lith.cloud:6666 www.baidu.com
curl http://www.baidu.com



curl -x ss.lith.cloud:7777  http://play.googleapis.com/generate_204
curl -x ss.lith.cloud:6666 https://www.google.com/?gws_rd=ssl
 


curl -x ss.lith.cloud:3128 https://www.google.com/?gws_rd=ssl



curl ip.sb --proxy ss.lith.cloud:8888 