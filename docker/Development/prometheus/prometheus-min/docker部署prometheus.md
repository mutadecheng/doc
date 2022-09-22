# docker部署
> 参考 https://www.cnblogs.com/xiao987334176/p/9930517.html
> https://prometheus.io/docs/introduction/overview/ 

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash

docker rm -f prometheus-grafana
docker rm -f prometheus
docker rm -f prometheus-exporter




# (x.1)node-exporter
> https://www.jianshu.com/p/7f586b482c44

docker run -d --restart=always \
--name prometheus-exporter \
-p 9100:9100 \
-v /etc/localtime:/etc/localtime \
-v "/proc:/host/proc:ro" \
-v "/sys:/host/sys:ro" \
-v "/:/rootfs:ro" \
prom/node-exporter:v1.2.2 \
--path.procfs /host/proc \
--path.sysfs /host/sys \
--collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"


# curl http://192.168.20.20:9100/metrics




# (x.2)prometheus
chmod 777 -R /root/docker/prometheus/prometheus
cd /root/docker/prometheus/prometheus
docker run -d --restart=always \
--name prometheus \
--link prometheus-exporter:exporter \
-p 9090:9090 \
-v /etc/localtime:/etc/localtime \
-v $PWD/data:/prometheus  \
-v $PWD/prometheus.yml:/etc/prometheus/prometheus.yml  \
prom/prometheus:v2.29.1 \
--config.file=/etc/prometheus/prometheus.yml \
--log.level=info \
--web.listen-address=0.0.0.0:9090 \
--storage.tsdb.path=/prometheus \
--storage.tsdb.retention=15d \
--query.max-concurrency=50 \
--web.enable-lifecycle


docker logs prometheus

--link prometheus-exporter:exporter \
--add-host exporter:192.168.20.20 \

# http://192.168.20.20:9090/graph
# http://192.168.20.20:9090/targets








#(x.3)grafana
chmod 777 -R /root/docker/prometheus/grafana
cd /root/docker/prometheus/grafana
docker run -d --restart=always \
--name prometheus-grafana \
--link prometheus \
-p 3000:3000 \
-v /etc/localtime:/etc/localtime \
-v $PWD/logs:/var/log/grafana \
-v $PWD/data:/var/lib/grafana \
-v $PWD/dashboards:/etc/grafana/provisioning/dashboards \
grafana/grafana:8.1.2


# http://192.168.20.20:3000
# 账号 admin/admin


#
Add data source
name Prometheus
type Prometheus
url http://prometheus:9090
Save & Test

#
New dashboard
https://grafana.com/grafana/dashboards


```

 
