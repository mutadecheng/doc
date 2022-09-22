# docker部署
> https://hub.docker.com/r/splunk/splunk
> https://splunk.github.io/docker-splunk/STORAGE_OPTIONS.html
> https://www.cnblogs.com/backlion/p/15701332.html 初识splunk
> https://www.cnblogs.com/jijizhazha/p/8534645.html splunk docker-compose 实现自定义 index

>  https://github.com/serilog-contrib/serilog-sinks-splunk    Serilog.Sinks.Splunk

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> -m 5120m 限制内存最大为5GB

``` bash

cd /root/docker/splunk
docker run --name splunk --restart=always -d \
-p 8000:8000 -p 8088:8088 --hostname so1 \
-v /etc/localtime:/etc/localtime \
-v $PWD/data:/opt/splunk/etc \
-v $PWD/conf:/opt/splunk/var  \
-e "SPLUNK_PASSWORD=Admin0123" \
-e "SPLUNK_START_ARGS=--accept-license" \
-e "SPLUNK_LICENSE_URI=Free" \
-m 2048m \
splunk/splunk

 


#管理界面地址(默认账户： admin/Admin0123)
http://192.168.20.20:8000

curl -k http://192.168.20.20:8088/services/collector -H 'Authorization: Splunk d6664b4a-d0af-4732-aea2-0009162f5f98' -d '{"sourcetype": "mysourcetype", "event":"Hello, World!"}'

curl -k http://192.168.20.20:8088/services/collector -H 'Authorization: Splunk d6664b4a-d0af-4732-aea2-0009162f5f98' -d '{"time":1426279439,"host":"localhost","source":"random-data-generator","sourcetype":"my_sample_data","index":"index_prod","event":{"level":"info","message":"Something happened","metadata":[],"namespace":"mc.sers.cloud","app":"mc"}}'

curl -k http://192.168.20.20:8088/services/collector -H 'Authorization: Splunk d6664b4a-d0af-4732-aea2-0009162f5f98' -d '[{"time":1426279439,"host":"localhost","source":"random-data-generator","sourcetype":"my_sample_data","index":"index_prod","event":{"level":"info","message":"Something happened","metadata":[],"namespace":"mc.sers.cloud","app":"mc"}}]'



```


# 3.容器常用命令

``` bash
#查看容器logs
docker logs splunk

#停止容器
docker stop splunk

#打开容器
docker start splunk

#重启容器
docker restart splunk

#删除容器
docker rm splunk -f

#进入容器执行命令
docker exec -it splunk bash

```
 

 