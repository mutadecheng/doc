# docker部署nginx
> 参考 https://www.runoob.com/docker/docker-install-nginx.html  

# 1.创建文件夹
> 创建文件目标文件夹/root/docker/nginx,把部署文件拷贝进去  


# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> -v $PWD/mime.types:/etc/nginx/mime.types 可选，映射mime

``` bash 
cd /root/docker/nginx
docker run --name nginx -d --restart=always \
--net=host \
-v /etc/localtime:/etc/localtime \
-v $PWD/app:/usr/share/nginx/app \
-v $PWD/conf.d:/etc/nginx/conf.d  \
-v $PWD/logs:/var/log/nginx \
nginx:1.17.5
```



# 3.容器常用命令

``` bash


#重新加载配置  
docker exec -it nginx nginx -s reload





#查看容器logs
docker logs nginx

#停止容器
docker stop nginx

#打开容器
docker start nginx

#重启容器
docker restart nginx

#删除容器
docker rm nginx -f


#进入容器执行命令
docker  exec -it nginx bash

#测试配置是否有语法错误
nginx -t   

docker exec -it nginx nginx -t

#重新加载配置  
nginx -s reload

docker exec -it nginx nginx -s reload

#重新加载配置|重启|停止|退出
nginx -s reload|reopen|stop|quit  


#从宿主机拷贝文件到容器
docker cp  nginx:/etc/nginx/nginx.conf /root/nginx/
docker cp  nginx:/etc/nginx/conf.d/ /root/nginx/conf.d
docker cp  nginx:/usr/share/nginx/html/ /root/nginx/html/

```
 