# docker部署mysql_5.6
> 参考 https://www.runoob.com/docker/docker-install-mysql.html


#1.创建文件夹
> 把部署文件（本文件夹）拷贝进去


#2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> -e MYSQL_ROOT_PASSWORD=123456：初始化 root 用户的密码

``` bash


cd /root/docker/mysql_5.6
#chmod 644 -R conf.d

docker run --restart=always -d \
--name mysql56 \
-p 3306:3306 \
-v /etc/localtime:/etc/localtime \
-v $PWD/conf.d:/etc/mysql/conf.d \
-v $PWD/logs:/logs \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql:5.6


```



#3.容器常用命令

``` bash
#常用命令

#查看容器logs
docker logs mysql56

#停止容器
docker stop mysql56

#打开容器
docker start mysql56

#重启容器
docker restart mysql56

#删除容器
docker rm mysql56 -f


#进入容器执行命令
docker exec -it mysql56 bash

mysql -u root -p
123456


#查看变量
show variables like 'performance_schema_max_table_instances' ;
show variables like 'table_definition_cache' ;
show variables like 'performance_schema' ;

-- 日志文件路径
show variables like 'general_log_file';

-- 错误日志文件路径
show variables like 'log_error';

-- 慢查询日志文件路径
show variables like 'slow_query_log_file';



```



 
#4.限制内存

##[法1]在docker创建命令后指定参数

``` bash
cd /root/docker/mysql_5.6
#chmod 644 -R conf.d

docker run --restart=always -d \
--name mysql56 \
-p 3306:3306 \
-v /etc/localtime:/etc/localtime \
-v $PWD/conf.d:/etc/mysql/conf.d \
-v $PWD/logs:/logs \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql:5.6 \
--performance_schema_max_table_instances=100 \
--table_definition_cache=64 \
--table_open_cache=32 \
--performance_schema=off


#查看支持的参数
docker run -it --rm mysql:5.6 --verbose --help
 
```



##[法2]修改文件 conf.d/docker.cnf,加入如下配置（按需修改大小）（已失效）
``` bash

#默认未设置，预置 10000 
performance_schema_max_table_instances = 100
#默认1400
table_definition_cache = 64
#默认2000
table_open_cache = 32
#performance_schema = off

 
```

