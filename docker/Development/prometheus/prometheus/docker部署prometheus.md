# docker部署
> 参考 https://www.cnblogs.com/zongxiang/p/12981592.html  Prometheus数据持久化存储
> https://www.cnblogs.com/xiao987334176/p/9930517.html
> https://prometheus.io/docs/introduction/overview/ 

mkdir /root/docker/prom



#-------------------------------------------------------------------------------------
# (x.1)influxdb

> 参考 https://blog.csdn.net/lomodays207/article/details/109748284    Docker安装部署influxdb以及用户认证登陆设置
> https://blog.csdn.net/caodanwang/article/details/51967393       配置influxDB 鉴权及 HTTP API 写数据

cd /root/docker/prom/influxdb
docker run -d --restart=always \
--name prom-influxdb \
-p 8086:8086 \
-p 8083:8083 \
-v /etc/localtime:/etc/localtime \
-v $PWD/influxdb:/var/lib/influxdb \
-v $PWD/influxdb.conf:/etc/influxdb/influxdb.conf \
-e INFLUXDB_DB=prometheus \
-e INFLUXDB_ADMIN_ENABLED=true \
-e INFLUXDB_ADMIN_USER=admin \
-e INFLUXDB_ADMIN_PASSWORD=adminpwd \
-e INFLUXDB_USER=prometheus \
-e INFLUXDB_USER_PASSWORD=prometheuspwd \
-e INFLUXDB_CONFIG_PATH=/etc/influxdb/influxdb.conf \
influxdb:1.8.9


#测试查询
curl -G -u prometheus:prometheuspwd 'http://127.0.0.1:8086/query' --data-urlencode "q=show databases;"

#控制台
docker exec -it prom-influxdb bash
influx -username 'admin' -password 'adminpwd'
show users;
show databases; 


#-------------------------------------------------------------------------------------
# (x.2)prometheus

chmod 777 -R /root/docker/prom/prometheus

cd /root/docker/prom/prometheus
docker run -d --restart=always \
--name prom \
--link prom-influxdb:influxdb \
-p 9090:9090 \
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


# http://192.168.1.45:9090/graph
# http://192.168.1.45:9090/targets









#-------------------------------------------------------------------------------------
# (x.3)prom-mysql

cd /root/docker/prom/mysql

chmod 777 -R ./
#chmod 644 -R conf.d 

docker run --restart=always -d \
--name prom-mysql \
-p 3306:3306 \
-v /etc/localtime:/etc/localtime \
-v $PWD/conf.d:/etc/mysql/conf.d \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
-e MYSQL_DATABASE=grafana \
-e MYSQL_USER=grafana \
-e MYSQL_PASSWORD=grafana \
mysql:8.0.25








#-------------------------------------------------------------------------------------
# (x.4)prom-grafana

chmod 777 -R /root/docker/prom/grafana

cd /root/docker/prom/grafana
docker run -d --restart=always \
--name prom-grafana \
-p 3000:3000 \
--link prom-mysql:mysql \
--link prom \
-v /etc/localtime:/etc/localtime \
-v $PWD/grafana.ini:/etc/grafana/grafana.ini \
-v $PWD/logs:/var/log/grafana \
-v $PWD/data:/var/lib/grafana \
-v $PWD/dashboards:/etc/grafana/provisioning/dashboards \
grafana/grafana:8.1.2




# http://192.168.1.45:3000/
# 账号 admin/admin


#
Add data source
name Prometheus
type Prometheus
url http://prom:9090
Save & Test

#
New dashboard



 



#-------------------------------------------------------------------------------------




#node-exporter
docker run -d --restart=always \
--name prometheus-exporter \
--net=host \
-p 9100:9100 \
-v "/proc:/host/proc:ro" \
-v "/sys:/host/sys:ro" \
-v "/:/rootfs:ro" \
prom/node-exporter:v1.2.2

# http://192.168.1.45:9100/metrics

