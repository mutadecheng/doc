#---------------------------------------
# bridge网络
> https://www.cnblogs.com/shenh/p/9714547.html

#创建bridge网络
docker network create net1

#创建容器并连接到网络 docker run -it --name <容器名> ---network <bridge> --network-alias <网络别名> <镜像名>
docker run -it --name centos-1 --network net1 --network-alias centos-1 docker.io/centos:latest
docker run -it --name centos-2 --network net1 --network-alias centos-2 docker.io/centos:latest


docker network connect net1 centos-1 --alias centos-1
docker network disconnect net1 centos-1

#Remove one or more networks
docker network rm net1


#查看网桥配置
docker network inspect bridge
docker network inspect nginx

#List networks
docker network ls


#Remove all unused networks
docker network prune
 

#---------------------------------------
# --link
https://www.jianshu.com/p/21d66ca6115e
#  --link selenium_hub:hub
# selenium_hub 和 hub作为容器的hostname，node用这2个名字中的哪一个都可以访问

docker run -d --name node --link selenium_hub:hub selenium/node-chrome-debug



#---------------------------------------
# 手动指定域名
--add-host pan.lith.cloud:192.168.20.20


