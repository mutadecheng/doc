Docker ��������������������

#  ������docker��ʱ������²���

# ����������rootȨ��
--privileged 

# �� Docker sock �ļ����ص�����
-v /var/run/docker.sock:/var/run/docker.sock 

# docker ������ص�����
-v /bin/docker:/bin/docker 
 

docker run -u root -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker --privileged  \
jenkins/jenkins:2.277.4-lts-centos7 bash

docker run -it --rm \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
busybox sh

 

  


#------------------------------

# https://www.jerryzone.cn/reboot-host-side-containers/

# ���ļ�ϵͳ�����л�Ϊ�������ļ�ϵͳ 

docker run -it --rm -v /:/host ubuntu bash

chroot /host /bin/bash

#��֤�漣
docker ps -a




#------------
#��������������
docker run -it --rm -v /:/host busybox sh

chroot /host /bin/bash

#��֤�漣
docker ps -a

#------------


