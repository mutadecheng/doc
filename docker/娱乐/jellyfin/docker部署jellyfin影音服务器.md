# docker����jellyfinӰ��������
> ֧��arm�ܹ�����ݮ��
> https://www.jianshu.com/p/f8ac045d8ffa


# 1.��������������
> --name �������ƣ����Զ���  
> --restart=always �Զ�����  
> -v /etc/localtime:/etc/localtime ����������localtime�ļ��������ʱ��������ʱ����һ�µ�����  
> -v $PWD/data:/data �������е�ǰĿ¼�µ�data���ص�������/data  
> --net=host ����ֱ��ʹ������������  
> -p 6022:6022 �˿�ӳ��  

``` bash

mkdir -p /root/docker/jellyfin/media

cd /root/docker/jellyfin
docker run --name=jellyfin --restart=always -d \
-p 8096:8096 \
-v $PWD/config:/config \
-v $PWD/media:/media \
jellyfin/jellyfin


```


http://192.168.0.153:8096


# 3.������������

``` bash
#�鿴����logs
docker logs jellyfin

#ֹͣ����
docker stop jellyfin

#������
docker start jellyfin

#��������
docker restart jellyfin

#ɾ������
docker rm jellyfin -f


#��������ִ������
docker exec -it jellyfin bash

```
