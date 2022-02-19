# CentOS 8 / RHEL 8 �ϰ�װ VirtualBox 6.0
> https://linux.cn/article-11627-1.html


#(x.1)���� VirtualBox �� EPEL �ֿ�

# ���� VirtualBox �� EPEL ���ֿ�
dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo

# ���� Oracle VirtualBox ��Կ
rpm --import https://www.virtualbox.org/download/oracle_vbox.asc

# ���� EPEL �ֿ�
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y




#(x.2)��װ VirtualBox �������ߺ�������
dnf install binutils kernel-devel kernel-headers libgomp make patch gcc glibc-headers glibc-devel dkms -y


#(x.3)��װ VirtualBox

#�г� VirtualBox �Ŀ��ð汾
dnf search virtualbox

#��װ VirtualBox
dnf install VirtualBox-6.1 -y

#ж��VirtualBox
# dnf remove VirtualBox-6.1 -y

#(x.4)����virtualbox
> �����滷���У��������������� ��VirtualBox��
virtualbox




#-------------------------------
# The vboxdrv kernel module is not loaded. Either there is no module available for the current kernel (4.13.0-36-generic) or it failed to load.
> https://blog.csdn.net/shuizhongmose/article/details/108382189
 


# ���ض�Ӧ��kernel���
https://rpmfind.net/linux/rpm2html/search.php?query=kernel-headers&submit=Search+...&system=&arch=


#��װ���
cd /root/temp
rpm -i kernel-headers-4.18.0-305.10.2.el8_4.x86_64.rpm


#���Please install the Linux kernel "header" files matching the current kernel����
yum -y install gcc kernel kernel-devel

#����,��������������
/sbin/vboxconfig





#-----------------------------------------------------------------
#�鿴�ں˰汾
uname -r
# 4.13.0-36-generic


#dnf remove binutils kernel-devel kernel-headers libgomp make patch gcc glibc-headers glibc-devel dkms -y

dnf search kernel-headers
kernel-headers-4.18.0-348.7.1.el8_5.x86_64




