# docker����
> https://www.home-assistant.io/installation/linux


# 1.��������������
> --name �������ƣ����Զ���  
> --restart=always �Զ�����  
> -v /etc/localtime:/etc/localtime ����������localtime�ļ��������ʱ��������ʱ����һ�µ�����  
> -v $PWD/data:/data �������е�ǰĿ¼�µ�data���ص�������/data  
> --net=host ����ֱ��ʹ������������  
> -p 6022:6022 �˿�ӳ��  


``` bash

mkdir -p /root/docker/HomeAssistant

cd /root/docker/HomeAssistant
docker run --restart=always -d --privileged \
--name homeassistant \
--net=host \
-v /etc/localtime:/etc/localtime \
-v $PWD/config:/config \
ghcr.io/home-assistant/home-assistant:stable


http://192.168.20.20:8123
lith/Commonpwd1



```




# 3.������������

``` bash
#�鿴����logs
docker logs homeassistant

#ֹͣ����
docker stop homeassistant

#������
docker start homeassistant

#��������
docker restart homeassistant

#ɾ������
docker rm homeassistant -f


#��������ִ������
docker exec -it homeassistant bash

```
