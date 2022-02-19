
#--------------------------------------
# centos-安装软件包
> https://blog.csdn.net/weixin_39644325/article/details/116910230
> 软件包下载：  https://vault.centos.org/8.3.2011/BaseOS/x86_64/os/Packages/
>               https://rpmfind.net/linux/rpm2html/search.php?query=kernel-headers&submit=Search+...&system=&arch=


wget http://vault.centos.org/5.7/os/x86_64/CentOS/kernel-headers-2.6.18-274.el5.x86_64.rpm

rpm -ivh kernel-headers-2.6.18-274.el5.x86_64.rpm



# 经常会遇到linux下安装软件时提示少文件，如何知道所缺少的文件属于哪个包？用什么命令查看？
> 例如:/lib/ld-linux.so.2: bad ELF interpreter: 没有那个文件或目录
> 如何判断知道ld-linux.so.2文件属于哪个包，知道后才能用yum安装，使用如下命令
yum provides "*/ld-linux.so.2"





#---------------------------------------------------
# Centos彻底完全删除已安装软件

#查询是否安装了软件
rpm -qa | grep -i kernel

#删除已安装的软件包
> rpm -e  -- 包名 # 普通删除模式
> rpm -e --nodeps 包名 #强力删除模式，如果用上面命令删除时，提示有依赖的其他文件，则用该命令可以对其进行强力删除
rpm -e  -- kernel-modules-4.18.0-348.7.1.el8_5.x86_64



