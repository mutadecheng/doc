--------------------------------------------------



https://www.cnblogs.com/nidey/p/6200685.html


-----------------------------------------------------
# 1.CentOS下载 RPM 包及其所有依赖包
https://www.xujun.org/note-8661.html


# 安装
yum install yum-plugin-downloadonly

# 下载软件包(含依赖包)
yum install -y --downloadonly --downloaddir=/root/docker/nginx/app/www/CentOS-8/ yum-utils
yum install -y --downloadonly --downloaddir=/root/docker/nginx/app/www/CentOS-8/  device-mapper-persistent-data  lvm2

#添加镜像源
yum install -y yum-utils
yum-config-manager  --add-repo   https://download.docker.com/linux/centos/docker-ce.repo

yum install -y --downloadonly --downloaddir=/root/docker/nginx/app/www/CentOS-8/  container-selinux

yum install -y --downloadonly --downloaddir=/root/docker/nginx/app/www/CentOS-8/  containerd.io-1.4.3-3.1.el8 
yum install -y --downloadonly --downloaddir=/root/docker/nginx/app/www/CentOS-8/ docker-ce-cli-19.03.14-3.el8
yum install -y --downloadonly --downloaddir=/root/docker/nginx/app/www/CentOS-8/ docker-ce-19.03.14-3.el8
 





-----------------------------------------------------
# 2.使用nginx制作yum包服务

https://blog.csdn.net/whatday/article/details/106573873 createrepo 创建本地 yum 仓库



yum install -y createrepo
createrepo /root/docker/nginx/app/www/CentOS-8


http://192.168.56.213/CentOS-8

-----------------------------------------------------
# 3.指定在线的yum包服务
https://www.cnblogs.com/daleyzou/p/Linux.html

cd /etc/yum.repos.d/
rename .repo .repo.bak *

touch CentOS-Local.repo

[base]
name=CentOS-Local
baseurl=http://192.168.56.213/CentOS-8
gpgcheck=0


#启用
yum clean all
yum repolist
yum clean packages
-----------------------------------------------------
# 4.指定本地离线包

cd /etc/yum.repos.d/
rename .repo .repo.bak *

touch CentOS-Local.repo

[base]
name=CentOS-Local
baseurl=file:///root/yum/CentOS-8
gpgcheck=0


#启用
yum clean all
yum repolist
yum clean packages
--------------------------------------------------
#安装相应的软件

yum list yum-utils
yum list lvm2
yum list device-mapper-persistent-data
yum list container-selinux
yum list docker-ce 
 

yum install -y yum-utils
yum install -y device-mapper-persistent-data  lvm2


rpm -ivh /root/yum/*.rpm --nodeps --force
#yum install -y container-selinux

yum install -y containerd.io-1.4.3-3.1.el8 
yum install docker-ce-cli-19.03.14-3.el8 -y
yum install docker-ce-19.03.14-3.el8 -y 
 

#查看docker版本
docker --version

#启动 Docker
systemctl start docker

#设置开机启动
systemctl enable docker



--------------------------------------------------



 
