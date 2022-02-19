# docker部署
> 参考 https://segon.cn/install-jenkins-using-docker.html
> https://hub.docker.com/r/jenkins/jenkins 
 

# 2.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

``` bash

cd /root/docker/jenkins
mkdir ./jenkins_home
chown -R 1000:1000 ./jenkins_home

docker run -d --restart=always \
--name jenkins \
--user root \
--env LANG=C.UTF-8 \
--env JAVA_OPTS=-Duser.timezone=Asia/Shanghai \
-p 8081:8080 -p 50000:50000 \
-v /:/host \
-v $PWD/jenkins_home:/var/jenkins_home \
jenkins/jenkins:2.277.4-lts-centos7 



 

#执行宿主命令
docker exec -it --user root jenkins bash 
chroot /host bash
docker ps -a


chroot /host bash -c "docker ps -a" 

```


#查看密码
#cat jenkins_home/secrets/initialAdminPassword
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

#登录
http://192.168.1.45:8081

```


# 3.容器常用命令

``` bash
#查看容器logs
docker logs jenkins

#停止容器
docker stop jenkins

#打开容器
docker start jenkins

#重启容器
docker restart jenkins

#删除容器
docker rm jenkins -f

#进入容器执行命令
docker exec -it jenkins bash
```
 


 
