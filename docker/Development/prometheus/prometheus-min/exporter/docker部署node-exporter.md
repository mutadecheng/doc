# node-exporter
> https://blog.csdn.net/weixin_40046357/article/details/121026734  使用Node Exporter自定义监控指标





# (x.1)采集硬盘温度


#支持sponge
apt install -y moreutils

#支持iostat
apt install -y sysstat

# add this to crontab
# */10 * * * * root sh /root/docker/prometheus/exporter/node_disk_info.sh | sponge /root/docker/prometheus/exporter/exporter/node_disk_info.prom

docker rm -f prometheus-exporter

docker run -d --restart=always \
--name prometheus-exporter \
-p 9100:9100 \
-v /etc/localtime:/etc/localtime \
-v "/proc:/host/proc:ro" \
-v "/sys:/host/sys:ro" \
-v "/:/rootfs:ro" \
-v /root/docker/prometheus/exporter/exporter:/exporter \
prom/node-exporter:v1.2.2 \
--path.procfs /host/proc \
--path.sysfs /host/sys \
--collector.textfile.directory /exporter \
--collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"


# curl http://192.168.2.21:9100/metrics




# HELP node_disk_temperature_now The temperature of disk currently
# TYPE node_disk_temperature_now gauge
node_disk_temperature_now{device="sda"} 36