# 使用Docker Registry快速搭建私有镜像仓库
> https://www.linuxidc.com/Linux/2018-03/151308.htm


#-------------------------------
#服务端（镜像仓库）

 

#(x.2)创建容器并运行
(--name 容器名称，可自定义)
(--restart=always 自动重启)
(-v /etc/localtime:/etc/localtime)挂载宿主机localtime文件解决容器时间与主机时区不一致的问题
(-v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data)
(--net=host 网络直接使用宿主机网络)（-p 6022:6022 端口映射）


chmod 777 -R /root/nfs/docker/docker-registry



cd /root/nfs/docker/docker-registry
docker run -d --restart=always --name registry -p 1100:5000 -v $PWD/registry:/var/lib/registry -v $PWD/config.yml:/etc/docker/registry/config.yml registry:2.7.1


#(x.3)应用已经运行

#获取镜像仓库中所有的镜像
curl http://127.0.0.1:1100/v2/_catalog
 
http://nas.i.lith.cloud:1100

#---------------------------------------
#常用命令

#查看容器logs
docker logs registry

#在容器内执行命令行
docker exec -it registry /bin/sh

#停止容器
docker stop registry

#打开容器
docker start registry

#重启容器
docker restart registry


#删除容器
docker rm registry -f



#-------------------------------
#客户端

#1 为镜像打标签
docker tag sers/dotnet/servicecenter:v1.2.0  serset.com:17005/sers/dotnet/servicecenter:v1.2.0

#2 查看一下打好的tag
docker images

#3 修改 daemon.json
需要https的方法才能上传，我们可以修改下daemon.json来解决：
#(x.1)修改文件 /etc/docker/daemon.json 
{
  "registry-mirrors": [ "http://hub-mirror.c.163.com"],
  "insecure-registries": [ "serset.com:17005"]   //添加此行
}
#(x.2)重启docker
systemctl  restart docker

#4 上传到镜像服务器
docker push serset.com:17005/sers/dotnet/servicecenter:v1.2.0


 
#5下载镜像
docker pull serset.com:17005/sers/dotnet/servicecenter:v1.2.0





#-------------------------------------------------------------
#配置允许删除镜像
https://www.cnblogs.com/cherylgi/p/13529983.html


#在启动仓库时，需在配置文件(/etc/docker/registry/config.yml)中的storage配置中增加配置项(  storage: delete: enabled: true)，允许删除镜像
 
#1、从容器拷贝文件到宿主机
docker cp registry:/etc/docker/registry/config.yml /root/temp/

#2、从宿主机拷贝文件到容器
docker cp /root/temp/config.yml registry:/etc/docker/registry/


#删除镜像
curl -I -X DELETE http://serset.com:17005/v2/sers/dotnet/servicecenter/manifests/sha256:7bf1860eff864d67647721233127cb492b7767b4ff1ba2e6366b40466681f05a
 



