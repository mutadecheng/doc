
#-------------------------------------
#ha开启自动发现


> https://www.home-assistant.io/integrations/mqtt
> https://jingyan.baidu.com/article/c45ad29c875786451753e29d.html

#-------------------------------------
#ha开启自动发现
> config/configuration.yaml

mqtt:
  # 配置自动发现
  discovery: true
  # 自动发现使用的主题位置前缀，缺省为 homeassistant
  discovery_prefix: homeassistant


#-------------------------------------
#订阅
docker run -it --rm eclipse-mosquitto sh
mosquitto_sub -h 192.168.20.20 -t homeassistant/#

#发布
docker run -it --rm eclipse-mosquitto sh
mosquitto_pub -h 192.168.20.20 -t /home -m "hello world!"  


#-------------------------------------
# Discovery topic
> https://www.home-assistant.io/docs/mqtt/discovery/
> <discovery_prefix>/<component>/[<node_id>/]<object_id>/config


#-------------------------------------
# sensor
> 传感器（如温度、湿度）
> 查看device_class https://www.home-assistant.io/integrations/sensor/#device-class

#添加设备
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/sensor/zhuwo/temperature/config" \
  -m '{"unique_id":"zhuwo_temperature_sensor",  "name":"zhuwo_temperature_sensor",  "device_class":"temperature",  "~":"homeassistant/sensor/zhuwo/temperature", "state_topic": "~/state"}'

#移除设备
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/sensor/zhuwo/temperature/config" -m ''

#Update the state
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/sensor/zhuwo/temperature/state" -m '15.5'


#-------------------------------------
# binary_sensor
> 二态传感器（其实是三态： 离线、在线-打开、在线-关闭）
> 查看device_class https://www.home-assistant.io/integrations/binary_sensor/#device-class

#添加设备
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/config" \
  -m '{"unique_id":"zhuwo_battery_binary_sensor", "name":"zhuwo_battery_binary_sensor", "device_class":"battery", "~":"homeassistant/binary_sensor/zhuwo/battery", "state_topic": "~/state", "availability_topic": "~/availability"}'

#移除设备
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/config" -m ''

#设置离线在线状态
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/availability" -m online
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/availability" -m offline


#设置打开关闭状态
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/state" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/state" -m OFF



#-------------------------------------
# switch 二态开关
> 查看device_class https://www.home-assistant.io/integrations/switch/#device-class
#添加设备
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light/config" \
  -m '{"unique_id":"zhuwo_light_switch", "name":"zhuwo_light_switch", "device_class":"switch", "~":"homeassistant/switch/zhuwo/light",  "command_topic":"~/set" }'

#移除设备
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light/config" -m ''

#发送 打开或关闭 指令
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light/state" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light/state" -m OFF



#-------------------------------------
# switch 三态开关（无开关状态）
> 离线、在线-打开、在线-关闭

#添加设备
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/config" \
  -m '{"unique_id":"zhuwo_light2_switch", "name":"zhuwo_light2_switch", "device_class":"switch", "~":"homeassistant/switch/zhuwo/light2",  "command_topic":"~/set", "availability_topic":"~/availability" }'

#移除设备
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/config" -m ''

#设置离线在线状态
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/availability" -m online
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/availability" -m offline


#发送 打开或关闭 指令
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/set" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/set" -m OFF


#监听状态变更指令
mosquitto_sub -h 192.168.20.20 -t homeassistant/switch/zhuwo/light2/#


#-------------------------------------
# switch 三态开关（手动控制开关状态）
> 离线、在线-打开、在线-关闭

#添加设备
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/config" \
  -m '{"unique_id":"zhuwo_light3_switch", "name":"zhuwo_light3_switch", "device_class":"switch", "~":"homeassistant/switch/zhuwo/light3",  "command_topic":"~/set", "availability_topic":"~/availability", "state_topic": "~/state" }'

#移除设备
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/config" -m ''

#设置离线在线状态
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/availability" -m online
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/availability" -m offline


#设置打开关闭状态
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/state" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/state" -m OFF

#发送 打开或关闭 指令
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/set" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/set" -m OFF


#监听状态变更指令
mosquitto_sub -h 192.168.20.20 -t homeassistant/switch/zhuwo/light3/#


#-------------------------------------
# lighting（无开关状态）
> https://www.home-assistant.io/integrations/light.mqtt/

#添加设备
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/config" \
  -m '{ "unique_id":"zhuwo_light_light", "name":"主卧灯", "~":"homeassistant/light/zhuwo/light", "command_topic":"~/set" }'

#移除设备
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/config" -m ''

#发送 打开或关闭 指令
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/set" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/set" -m OFF

#监听状态变更指令
mosquitto_sub -h 192.168.20.20 -t homeassistant/light/zhuwo/light/#


#-------------------------------------
# lighting（手动控制开关状态）

#添加设备
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/config" \
  -m '{"unique_id":"zhuwo_light_light", "name":"主卧灯", "~":"homeassistant/light/zhuwo/light", "command_topic":"~/set", "availability_topic":"~/availability", "state_topic":"~/state" }'

#移除设备
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/config" -m ''


#设置离线在线状态
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/availability" -m online
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/availability" -m offline


#设置打开关闭状态
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/state" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/state" -m OFF

#发送 打开或关闭 指令
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/set" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/set" -m OFF


#监听状态变更指令
mosquitto_sub -h 192.168.20.20 -t homeassistant/light/zhuwo/light/#


#-------------------------------------
# button
> 查看device_class https://www.home-assistant.io/integrations/button/#device-class
None: Generic button. This is the default and doesn’t need to be set.
restart: The button restarts the device.
update: The button updates the software of the device.

#添加设备
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/button/zhuwo/light/config" \
  -m '{"unique_id":"zhuwo_light_button", "name":"zhuwo_light_button", "device_class":"None", "~":"homeassistant/button/zhuwo/light", "command_topic":"~/set", "availability_topic":"~/availability"}'

#移除设备
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/button/zhuwo/light/config" -m ''

#设置离线在线状态
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/button/zhuwo/light/availability" -m online
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/button/zhuwo/light/availability" -m offline

#按下事件
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/button/zhuwo/light/set" -m PRESS

#监听状态变更指令
mosquitto_sub -h 192.168.20.20 -t homeassistant/button/zhuwo/light/#


