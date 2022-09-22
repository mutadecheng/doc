
#-------------------------------------
#ha�����Զ�����


> https://www.home-assistant.io/integrations/mqtt
> https://jingyan.baidu.com/article/c45ad29c875786451753e29d.html

#-------------------------------------
#ha�����Զ�����
> config/configuration.yaml

mqtt:
  # �����Զ�����
  discovery: true
  # �Զ�����ʹ�õ�����λ��ǰ׺��ȱʡΪ homeassistant
  discovery_prefix: homeassistant


#-------------------------------------
#����
docker run -it --rm eclipse-mosquitto sh
mosquitto_sub -h 192.168.20.20 -t homeassistant/#

#����
docker run -it --rm eclipse-mosquitto sh
mosquitto_pub -h 192.168.20.20 -t /home -m "hello world!"  


#-------------------------------------
# Discovery topic
> https://www.home-assistant.io/docs/mqtt/discovery/
> <discovery_prefix>/<component>/[<node_id>/]<object_id>/config


#-------------------------------------
# sensor
> �����������¶ȡ�ʪ�ȣ�
> �鿴device_class https://www.home-assistant.io/integrations/sensor/#device-class

#����豸
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/sensor/zhuwo/temperature/config" \
  -m '{"unique_id":"zhuwo_temperature_sensor",  "name":"zhuwo_temperature_sensor",  "device_class":"temperature",  "~":"homeassistant/sensor/zhuwo/temperature", "state_topic": "~/state"}'

#�Ƴ��豸
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/sensor/zhuwo/temperature/config" -m ''

#Update the state
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/sensor/zhuwo/temperature/state" -m '15.5'


#-------------------------------------
# binary_sensor
> ��̬����������ʵ����̬�� ���ߡ�����-�򿪡�����-�رգ�
> �鿴device_class https://www.home-assistant.io/integrations/binary_sensor/#device-class

#����豸
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/config" \
  -m '{"unique_id":"zhuwo_battery_binary_sensor", "name":"zhuwo_battery_binary_sensor", "device_class":"battery", "~":"homeassistant/binary_sensor/zhuwo/battery", "state_topic": "~/state", "availability_topic": "~/availability"}'

#�Ƴ��豸
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/config" -m ''

#������������״̬
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/availability" -m online
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/availability" -m offline


#���ô򿪹ر�״̬
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/state" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/binary_sensor/zhuwo/battery/state" -m OFF



#-------------------------------------
# switch ��̬����
> �鿴device_class https://www.home-assistant.io/integrations/switch/#device-class
#����豸
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light/config" \
  -m '{"unique_id":"zhuwo_light_switch", "name":"zhuwo_light_switch", "device_class":"switch", "~":"homeassistant/switch/zhuwo/light",  "command_topic":"~/set" }'

#�Ƴ��豸
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light/config" -m ''

#���� �򿪻�ر� ָ��
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light/state" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light/state" -m OFF



#-------------------------------------
# switch ��̬���أ��޿���״̬��
> ���ߡ�����-�򿪡�����-�ر�

#����豸
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/config" \
  -m '{"unique_id":"zhuwo_light2_switch", "name":"zhuwo_light2_switch", "device_class":"switch", "~":"homeassistant/switch/zhuwo/light2",  "command_topic":"~/set", "availability_topic":"~/availability" }'

#�Ƴ��豸
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/config" -m ''

#������������״̬
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/availability" -m online
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/availability" -m offline


#���� �򿪻�ر� ָ��
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/set" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light2/set" -m OFF


#����״̬���ָ��
mosquitto_sub -h 192.168.20.20 -t homeassistant/switch/zhuwo/light2/#


#-------------------------------------
# switch ��̬���أ��ֶ����ƿ���״̬��
> ���ߡ�����-�򿪡�����-�ر�

#����豸
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/config" \
  -m '{"unique_id":"zhuwo_light3_switch", "name":"zhuwo_light3_switch", "device_class":"switch", "~":"homeassistant/switch/zhuwo/light3",  "command_topic":"~/set", "availability_topic":"~/availability", "state_topic": "~/state" }'

#�Ƴ��豸
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/config" -m ''

#������������״̬
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/availability" -m online
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/availability" -m offline


#���ô򿪹ر�״̬
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/state" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/state" -m OFF

#���� �򿪻�ر� ָ��
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/set" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/switch/zhuwo/light3/set" -m OFF


#����״̬���ָ��
mosquitto_sub -h 192.168.20.20 -t homeassistant/switch/zhuwo/light3/#


#-------------------------------------
# lighting���޿���״̬��
> https://www.home-assistant.io/integrations/light.mqtt/

#����豸
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/config" \
  -m '{ "unique_id":"zhuwo_light_light", "name":"���Ե�", "~":"homeassistant/light/zhuwo/light", "command_topic":"~/set" }'

#�Ƴ��豸
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/config" -m ''

#���� �򿪻�ر� ָ��
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/set" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/set" -m OFF

#����״̬���ָ��
mosquitto_sub -h 192.168.20.20 -t homeassistant/light/zhuwo/light/#


#-------------------------------------
# lighting���ֶ����ƿ���״̬��

#����豸
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/config" \
  -m '{"unique_id":"zhuwo_light_light", "name":"���Ե�", "~":"homeassistant/light/zhuwo/light", "command_topic":"~/set", "availability_topic":"~/availability", "state_topic":"~/state" }'

#�Ƴ��豸
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/config" -m ''


#������������״̬
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/availability" -m online
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/availability" -m offline


#���ô򿪹ر�״̬
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/state" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/state" -m OFF

#���� �򿪻�ر� ָ��
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/set" -m ON
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/light/zhuwo/light/set" -m OFF


#����״̬���ָ��
mosquitto_sub -h 192.168.20.20 -t homeassistant/light/zhuwo/light/#


#-------------------------------------
# button
> �鿴device_class https://www.home-assistant.io/integrations/button/#device-class
None: Generic button. This is the default and doesn��t need to be set.
restart: The button restarts the device.
update: The button updates the software of the device.

#����豸
mosquitto_pub -r -h 192.168.20.20 -p 1883 -t "homeassistant/button/zhuwo/light/config" \
  -m '{"unique_id":"zhuwo_light_button", "name":"zhuwo_light_button", "device_class":"None", "~":"homeassistant/button/zhuwo/light", "command_topic":"~/set", "availability_topic":"~/availability"}'

#�Ƴ��豸
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/button/zhuwo/light/config" -m ''

#������������״̬
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/button/zhuwo/light/availability" -m online
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/button/zhuwo/light/availability" -m offline

#�����¼�
mosquitto_pub -h 192.168.20.20 -p 1883 -t "homeassistant/button/zhuwo/light/set" -m PRESS

#����״̬���ָ��
mosquitto_sub -h 192.168.20.20 -t homeassistant/button/zhuwo/light/#


