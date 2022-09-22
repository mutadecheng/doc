
#--------------------------------------------------------------------
#(x.3)docker部署onlyoffice
 https://zhuanlan.zhihu.com/p/137126161



#精简部署
docker run --restart=always -d \
--name nextcloud-onlyoffice \
-p 16191:80 \
-e JWT_ENABLED=true \
-e JWT_SECRET=Commonpwd1 \
onlyoffice/documentserver:6.3.1.32



#部署
cd /root/NextCloud/nextcloud
docker run --restart=always -d \
--name nextcloud-onlyoffice \
-p 16191:80 \
-p 6191:443 \
-v $PWD/onlyoffice/conf.d:/etc/nginx/conf.d \
-e JWT_ENABLED=true \
-e JWT_SECRET=Commonpwd1 \
onlyoffice/documentserver:6.3.1.32



#文档编辑服务地址 
http://192.168.1.45:16191

https://pan.sers.cloud:6191/



docker rm -f nextcloud-onlyoffice
docker exec -it nextcloud-onlyoffice bash

