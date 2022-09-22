iptables v1.4.14：无法初始化iptables table`nat'：表不存在（你是否需要insmod？）
> https://cloud.tencent.com/developer/ask/120754

#解决方法

#加载ip_tables
modprobe ip_tables

#查看状态
lsmod | grep ip_tables
modinfo ip_tables



#报错信息
modprobe: can't change directory to '/lib/modules': No such file or directory
modprobe: can't change directory to '/lib/modules': No such file or directory
iptables v1.8.6 (legacy): can't initialize iptables table `nat': Table does not exist (do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
modprobe: can't change directory to '/lib/modules': No such file or directory
modprobe: can't change directory to '/lib/modules': No such file or directory
iptables v1.8.6 (legacy): can't initialize iptables table `nat': Table does not exist (do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.







#------------------------------------------------
CentOS8的防火墙由原来的 iptables 切换成了 nftables ，docker依赖于iptables来进行防火墙规则设置，目前官方还未兼容nftables。
> http://blog.exsvc.cn/article/centos8-install-docker-ce.html
> https://www.cnblogs.com/paidaxing7090/p/14140902.html

