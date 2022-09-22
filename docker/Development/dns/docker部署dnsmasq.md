# docker部署
> http://www.coderli.com/config-dnsmasq-using-docker/

# 1.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

 

``` bash
# 创建容器
docker run -it --rm --name dns-server -p 53:53/tcp -p 53:53/udp   andyshinn/dnsmasq:2.75
 
``` 

 
 

 


 