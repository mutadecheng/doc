#---------------------------------------
# bridge����
> https://www.cnblogs.com/shenh/p/9714547.html

#����bridge����
docker network create net1

#�������������ӵ����� docker run -it --name <������> ---network <bridge> --network-alias <�������> <������>
docker run -it --name centos-1 --network net1 --network-alias centos-1 docker.io/centos:latest
docker run -it --name centos-2 --network net1 --network-alias centos-2 docker.io/centos:latest


docker network connect net1 centos-1 --alias centos-1
docker network disconnect net1 centos-1

#Remove one or more networks
docker network rm net1


#�鿴��������
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
# selenium_hub �� hub��Ϊ������hostname��node����2�������е���һ�������Է���

docker run -d --name node --link selenium_hub:hub selenium/node-chrome-debug



#---------------------------------------
# �ֶ�ָ������
--add-host pan.lith.cloud:192.168.20.20


