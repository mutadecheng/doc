# docker����jellyfinӰ��������
> https://zhuanlan.zhihu.com/p/448769048
> https://post.smzdm.com/p/ad28lg6d/ Jellyfinһ������޹���˽��Ӱ��APP
> https://jellyfin.org/posts/android-v2.3.0/
> https://repo.jellyfin.org/releases/client/android/ android app

# 1.��������������
> --name �������ƣ����Զ���  
> --restart=always �Զ�����  
> -v /etc/localtime:/etc/localtime ����������localtime�ļ��������ʱ��������ʱ����һ�µ�����  
> -v $PWD/data:/data �������е�ǰĿ¼�µ�data���ص�������/data  
> --net=host ����ֱ��ʹ������������  
> -p 6022:6022 �˿�ӳ��  

``` bash

mkdir -p /root/docker/jellyfin/media


docker rm jellyfin -f


cd /root/docker/jellyfin
docker run --name=jellyfin --restart=always -d \
-p 8096:8096 \
-v $PWD/media:/media:ro \
-v $PWD/config:/config \
-v $PWD/cache:/cache \
-v $PWD/fonts:/usr/share/fonts/truetype/dejavu \
--device=/dev/dri \
-e PUID=0 \
-e PGID=0 \
-e TZ=Asia/Shanghai \
nyanmisaka/jellyfin



-v /srv/dev-disk-by-uuid-0001043F0004DD59/movie:/media:ro \
-v $PWD/media:/media:ro \





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




#------------------------------
#Ӳ������
���� ������ ���� ת�� 
   Ӳ������  Video Acceleration API(VAAPI)
   VA-API �豸 /dev/dri/renderD128



#----------------
#��ʾ���루��Ļ���ļ�������
> https://post.smzdm.com/p/ad28lg6d/

#1.�ҵ�һ���������壬��·����C:\Windows\Fonts��������6�ݣ��������£�
DejaVuSans.ttf
DejaVuSans-Bold.ttf
DejaVuSansMono.ttf
DejaVuSansMono-Bold.ttf
DejaVuSerif.ttf
DejaVuSerif-Bold.ttf

#2.���Ƶ�font�ļ��в�ӳ�䵽����
-v $PWD/fonts:/usr/share/fonts/truetype/dejavu \

#3.�����Ļ����
jellyfin����̨-����
	���������ļ�·�� /usr/share/fonts/truetype/dejavu
	���ñ������� ��ѡ
Ȼ�󱣴漴��


