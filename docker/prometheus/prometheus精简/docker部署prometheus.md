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


# (x.1)node-exporter
docker run -d --restart=always \
--name prometheus-exporter \
--net=host \
-p 9100:9100 \
-v "/proc:/host/proc:ro" \
-v "/sys:/host/sys:ro" \
-v "/:/rootfs:ro" \
prom/node-exporter:v1.2.2

# http://192.168.1.45:9100/metrics




# (x.2)prometheus
cd /root/docker/prometheus
docker run -d --restart=always \
--name prometheus \
--net=host \
-p 9090:9090 \
-v $PWD/prometheus.yml:/etc/prometheus/prometheus.yml  \
prom/prometheus:v2.29.1

# http://192.168.1.45:9090/graph
# http://192.168.1.45:9090/targets








#(x.3)grafana
chmod 777 -R /root/docker/prometheus/grafana
cd /root/docker/prometheus
docker run -d --restart=always \
--name prometheus-grafana \
-p 3000:3000 \
-v $PWD/grafana:/var/lib/grafana \
grafana/grafana:8.1.2


# http://192.168.1.45:3000/
# 账号 admin/admin


#
Add data source
name Prometheus
type Prometheus
url http://192.168.1.45:9090
Save & Test

#
New dashboard



```

 
