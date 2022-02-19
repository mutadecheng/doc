Docker 容器中运行宿主的命令

#  在启动docker的时候加以下参数

# 该容器启用root权限
--privileged 

# 将 Docker sock 文件挂载到容器
-v /var/run/docker.sock:/var/run/docker.sock 

# docker 命令挂载到容器
-v /bin/docker:/bin/docker 
 

docker run -u root -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker --privileged  \
jenkins/jenkins:2.277.4-lts-centos7 bash

docker run -it --rm \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
busybox sh

 

  


#------------------------------

# https://www.jerryzone.cn/reboot-host-side-containers/

# 将文件系统环境切换为宿主机文件系统 

docker run -it --rm -v /:/host ubuntu bash

chroot /host /bin/bash

#见证奇迹
docker ps -a




#------------
#运行宿主的命令
docker run -it --rm -v /:/host busybox sh

chroot /host /bin/bash

#见证奇迹
docker ps -a

#------------


