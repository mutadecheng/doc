# docker-exporter
> https://blog.csdn.net/weixin_43815140/article/details/119730821  Prometheus监控docker容器



docker rm -f prometheus-cadvisor

docker run -d --restart=always \
--name=prometheus-cadvisor --privileged=true \
-p 9101:8080 \
-v /:/rootfs:ro -v /var/run:/var/run/:rw -v /sys:/sys:ro -v /var/lib/docker:/var/lib/docker:ro google/cadvisor

docker logs prometheus-cadvisor

# curl http://192.168.20.20:9101/containers/


#编辑prometheus配置文件，在static_configs下面修改
#以下添加的ip都将会被监控起来
    - targets: ['192.168.20.20:9101']



#dashboard
https://grafana.com/grafana/dashboards/11277-docker/