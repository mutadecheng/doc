# CentOS 8 / RHEL 8 上安装 VirtualBox 6.0
> https://linux.cn/article-11627-1.html


#(x.1)启用 VirtualBox 和 EPEL 仓库

# 启用 VirtualBox 和 EPEL 包仓库
dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo

# 导入 Oracle VirtualBox 公钥
rpm --import https://www.virtualbox.org/download/oracle_vbox.asc

# 启用 EPEL 仓库
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y




#(x.2)安装 VirtualBox 构建工具和依赖项
dnf install binutils kernel-devel kernel-headers libgomp make patch gcc glibc-headers glibc-devel dkms -y


#(x.3)安装 VirtualBox

#列出 VirtualBox 的可用版本
dnf search virtualbox

#安装 VirtualBox
dnf install VirtualBox-6.1 -y

#卸载VirtualBox
# dnf remove VirtualBox-6.1 -y

#(x.4)启动virtualbox
> 在桌面环境中，在搜索框中搜索 “VirtualBox”
virtualbox




#-------------------------------
# The vboxdrv kernel module is not loaded. Either there is no module available for the current kernel (4.13.0-36-generic) or it failed to load.
> https://blog.csdn.net/shuizhongmose/article/details/108382189
 


# 下载对应的kernel插件
https://rpmfind.net/linux/rpm2html/search.php?query=kernel-headers&submit=Search+...&system=&arch=


#安装插件
cd /root/temp
rpm -i kernel-headers-4.18.0-305.10.2.el8_4.x86_64.rpm


#解决Please install the Linux kernel "header" files matching the current kernel问题
yum -y install gcc kernel kernel-devel

#重启,后允许如下命令
/sbin/vboxconfig





#-----------------------------------------------------------------
#查看内核版本
uname -r
# 4.13.0-36-generic


#dnf remove binutils kernel-devel kernel-headers libgomp make patch gcc glibc-headers glibc-devel dkms -y

dnf search kernel-headers
kernel-headers-4.18.0-348.7.1.el8_5.x86_64




