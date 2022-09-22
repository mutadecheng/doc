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
> 

``` bash 
cd /root/docker/nginx
docker run --name nginx -d --restart=always \
--net=host \
-v /etc/localtime:/etc/localtime \
-v $PWD/app:/usr/share/nginx/app \
-v $PWD/conf.d:/etc/nginx/conf.d  \
-v $PWD/logs:/var/log/nginx \
nginx:1.17.5


# 映射mime
-v $PWD/mime.types:/etc/nginx/mime.types \
# 映射nginx.conf
-v $PWD/nginx.conf:/etc/nginx/nginx.conf \

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


#-------------------------
#进入容器执行命令
docker exec -it nginx bash

#查看端口
netstat -an | grep 1935

nginx -V 

#测试配置是否有语法错误
nginx -t
docker exec -it nginx nginx -t

#重新加载配置  
nginx -s reload
docker exec -it nginx nginx -s reload

#重新加载配置|重启|停止|退出
nginx -s reload|reopen|stop|quit  


#从宿主机拷贝文件到容器
docker cp nginx:/etc/nginx/nginx.conf /root/nginx/
docker cp nginx:/etc/nginx/conf.d/ /root/nginx/conf.d
docker cp nginx:/usr/share/nginx/html/ /root/nginx/html/

```
 
#------------------------------------------------------
# (x.1).resolver
> https://blog.csdn.net/Leopard_89/article/details/113619558
> https://www.rootop.org/pages/4307.html nginx中resolver参数配置解释
只有设置了变量,而且proxy_pass值是域名，resolver才生效。

set $domain_name "i.nextcloud.sers.cloud:6190";
resolver 140.205.81.17 valid=5s ipv6=off;
location / { 
	proxy_pass http://$domain_name;
}

#------------------------------------------------------
# (x.2)解决重定向后https变成了http的问题
location / { 

	#传递客户端ip	 
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Real-Port $remote_port;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header Host $host:$server_port;

	#解决重定向后https变成了http的问题
	proxy_redirect http:// https://;

	proxy_pass http://localhost:2003;


	client_max_body_size 50000m;
	client_body_buffer_size 1024k;
}


#------------------------------------------------------
# (x.3)允许跨域

server {
	listen 8;    
	server_name ms.clean.lith.cloud;

	location / {

		proxy_pass http://localhost:2100;

		# configuration with allow cross domain
		add_header 'Access-Control-Allow-Origin' '*';
		add_header 'Access-Control-Allow-Credentials' 'true';
	}
 
}


