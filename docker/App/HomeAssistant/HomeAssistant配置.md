
#-------------------------------------
#haǿ��ɾ��ʵ��

��ha��state restore��config/.storage/core.restore_state���ļ��У��ҵ���Ӧ��entity id��ɾ��������ha��




#-------------------------------------
#ha����nginx�������


#(1)�鿴nginx����ip
docker network inspect InnerNet 
> "IPv4Address": "172.21.0.10/16",


#(2)�޸��ļ� docker/HomeAssistant/config/configuration.yaml�������������
http:
  use_x_forwarded_for: True
  trusted_proxies:
    - 172.21.0.10

#(3)����HA����ͨ��nginx�������
