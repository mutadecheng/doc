iptables v1.4.14���޷���ʼ��iptables table`nat'�������ڣ����Ƿ���Ҫinsmod����
> https://cloud.tencent.com/developer/ask/120754

#�������

#����ip_tables
modprobe ip_tables

#�鿴״̬
lsmod | grep ip_tables
modinfo ip_tables



#������Ϣ
modprobe: can't change directory to '/lib/modules': No such file or directory
modprobe: can't change directory to '/lib/modules': No such file or directory
iptables v1.8.6 (legacy): can't initialize iptables table `nat': Table does not exist (do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
modprobe: can't change directory to '/lib/modules': No such file or directory
modprobe: can't change directory to '/lib/modules': No such file or directory
iptables v1.8.6 (legacy): can't initialize iptables table `nat': Table does not exist (do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.







#------------------------------------------------
CentOS8�ķ���ǽ��ԭ���� iptables �л����� nftables ��docker������iptables�����з���ǽ�������ã�Ŀǰ�ٷ���δ����nftables��
> http://blog.exsvc.cn/article/centos8-install-docker-ce.html
> https://www.cnblogs.com/paidaxing7090/p/14140902.html

