# docker部署
> https://blog.csdn.net/a56546/article/details/124582284 部署elasticsearch以及集群部署
> https://www.cnblogs.com/BananaMan666/p/16203395.html https://juejin.cn/post/7079725598650105870
> https://www.jianshu.com/p/d6a54b498283 Docker 部署 Elasticsearch - 权限认证
https://www.cnblogs.com/zongxiang/p/14745073.html



# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射
> -m 5120m 限制内存最大为5GB





``` bash

#--------------------------------------------------------------
# (1)部署elasticsearch
mkdir -p cd /root/docker/elasticsearch/elasticsearch/data
chmod 777 /root/docker/elasticsearch/

cd /root/docker/elasticsearch/elasticsearch
docker run --name es --restart=always -d \
-p 9200:9200 -p 9300:9300 \
-v /etc/localtime:/etc/localtime \
-v $PWD/data:/usr/share/elasticsearch/data \
-v $PWD/plugins:/usr/share/elasticsearch/plugins \
-v $PWD/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-e ES_JAVA_OPTS="-Xms64m -Xmx256m"  \
-e "discovery.type=single-node" \
-m 1024m \
elasticsearch:7.10.1


#浏览器访问
 http://192.168.20.20:9200


curl http://localhost:9200




#删除索引
curl -XDELETE http://192.168.20.20:9200/dev

#创建索引
curl -XPUT 'http://192.168.20.20:9200/dev' -H "Content-Type: application/json" -d '
{ "mappings":{
    "properties":{
      "@timestamp":{"type":"date"},
      "time":{"type":"date"}
    }
  }
}'

 
#批量导入数据
curl -k -X POST http://192.168.20.20:9200/dev/_doc/_bulk -H "Content-Type: application/json" -d '{"create":{}}
{"@timestamp": "2022-05-25T08:48:16.905Z","time":"2022-05-25T08:48:16.905Z","level":"error","message":"hello world!","metadata":[{"errorCode":404,"errorMessage":"hello world!","errorTag":"150721_lith_1"}],"appInfo":{"namespace":"sers.cloud","appName":"mc","moduleName":"ServiceCenter"}}
'



#查看容器logs
docker logs es

#停止容器
docker stop es

#打开容器
docker start es

#重启容器
docker restart es

#删除容器
docker rm es -f

#进入容器执行命令
docker exec -it es bash

#-------------------------------------------------------------- 
# (2)部署kibana
docker run --name kibana --restart=always -d \
-p 5601:5601 \
-v /etc/localtime:/etc/localtime \
-e ELASTICSEARCH_HOSTS=http://192.168.20.20:9200  \
kibana:7.10.1


 
#查看容器logs
docker logs kibana

#停止容器
docker stop kibana

#打开容器
docker start kibana

#重启容器
docker restart kibana

#删除容器
docker rm kibana -f

#进入容器执行命令
docker exec -it kibana bash




#浏览器访问
 http://192.168.20.20:5601

#创建索引
 Stack Management -> Index Patterns -> Create index pattern -> Time field: @timestamp -> Create index pattern
 kibana -> discover

#-------------------------------------------------------------- 
# (3)部署Filebeat
> https://blog.csdn.net/m0_38030719/article/details/109182259

cd /root/docker/elasticsearch/filebeat
docker run --name filebeat --restart=always -d \
--user=root \
-v /etc/localtime:/etc/localtime \
-v $PWD/filebeat.yml:/usr/share/filebeat/filebeat.yml \
-v /var/lib/docker/containers:/var/lib/docker/containers \
elastic/filebeat:7.9.2
 


#查看容器logs
docker logs filebeat

#停止容器
docker stop filebeat

#打开容器
docker start filebeat

#重启容器
docker restart filebeat

#删除容器
docker rm filebeat -f

#进入容器执行命令
docker exec -it filebeat bash





```