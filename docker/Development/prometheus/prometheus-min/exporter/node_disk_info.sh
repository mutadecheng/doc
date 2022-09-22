#!/bin/sh
#
# Expose disk temperature
#
# add this to crontab
# */10 * * * * root sh /root/docker/prometheus/exporter/node_disk_info.sh | sponge /root/docker/prometheus/exporter/exporter/node_disk_info.prom
#

# apt install -y moreutils
# apt install -y sysstat

#温度
temperature="# HELP node_disk_temperature_now The temperature of disk currently\n# TYPE node_disk_temperature_now gauge"

#启动/停止计数
Start_Stop_Count="# HELP node_disk_Start_Stop_Count\n# TYPE node_disk_Start_Stop_Count counter"

#累计通电时间
Power_On_Hours="# HELP node_disk_Power_On_Hours\n# TYPE node_disk_Power_On_Hours counter"

#磁盘通电次数
Power_Cycle_Count="# HELP node_disk_Power_Cycle_Count\n# TYPE node_disk_Power_Cycle_Count counter"
  

for disk in `iostat -dm 1 2 | tail -n +$(iostat -dm | wc -l) | awk '{if ( $3~/^([0-9\.])+$/ && ($3>0 || $4>0)) print $1}'`;
do
	smartInfo=$(smartctl -a /dev/$disk)

	value=$(echo "$smartInfo" |grep -i Temperature_Celsius |awk '{print $10}')
	[ ! -z "$value" ] && temperature="${temperature}\nnode_disk_temperature_now{device=\"$disk\"} ${value}"

	value=$(echo "$smartInfo" |grep -i Start_Stop_Count |awk '{print $10}')
	[ ! -z "$value" ] && Start_Stop_Count="${Start_Stop_Count}\nnode_disk_Start_Stop_Count{device=\"$disk\"} ${value}"

	value=$(echo "$smartInfo" |grep -i Power_On_Hours |awk '{print $10}')
	[ ! -z "$value" ] && Power_On_Hours="${Power_On_Hours}\nnode_disk_Power_On_Hours{device=\"$disk\"} ${value}"

	value=$(echo "$smartInfo" |grep -i Power_Cycle_Count |awk '{print $10}')
	[ ! -z "$value" ] && Power_Cycle_Count="${Power_Cycle_Count}\nnode_disk_Power_Cycle_Count{device=\"$disk\"} ${value}"
done

echo $temperature
echo $Start_Stop_Count
echo $Power_On_Hours
echo $Power_Cycle_Count