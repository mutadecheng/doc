# docker部署
> zipkin

 

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash
docker run --name=zipkin --restart=always -d -p 9411:9411 saved/zipkin

# 管理页面 http://ip:9411/zipkin/

```


# 3.容器常用命令

``` bash
#查看容器logs
docker logs zipkin

#停止容器
docker stop zipkin

#打开容器
docker start zipkin

#重启容器
docker restart zipkin

#删除容器
docker rm zipkin -f

#进入容器执行命令
docker  exec -it zipkin /bin/sh
```
 


# 5.其他
> copy from openzipkin/zipkin，故文中的镜像地址 openzipkin/zipkin 亦可改为 openzipkin/zipkin
> 参见 https://hub.docker.com/r/openzipkin/zipkin
> 参考 https://www.cnblogs.com/cag2050/p/11663577.html

``` bash
# 备份docker镜像
# docker login -u saved -p xxx
docker pull openzipkin/zipkin:2.23
docker tag openzipkin/zipkin:2.23 saved/zipkin:2.23
docker push saved/zipkin:2.23
docker tag openzipkin/zipkin:2.23 saved/zipkin
docker push saved/zipkin
```