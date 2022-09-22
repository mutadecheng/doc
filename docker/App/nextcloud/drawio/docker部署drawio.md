
#--------------------------------------------------------------------
#docker部署drawio
 https://zhuanlan.zhihu.com/p/390430139



#部署
docker run --restart=always -d \
--name nextcloud-drawio \
-p 2063:8080 \
jgraph/drawio



#文档编辑服务地址 
http://192.168.2.21:2063


docker logs nextcloud-drawio
docker rm -f nextcloud-drawio
docker exec -it nextcloud-drawio bash

