-----------------------------------------------
#��������

#1.�鿴��ǰ����
ifconfig
nmcli connection show
 
#2.��������enp0s8
nmcli connection add type ethernet con-name enp0s8 ifname enp0s8
nmcli connection show

#3.��������enp0s8
ifup enp0s8

-----------------------------------------------

#���þ�̬ip
ifconfig

#��������
nmcli connection add type ethernet con-name enp0s9 ifname enp0s9
#nmcli connection show 
#nmcli connection delete enp0s9

#�޸����������ļ�
nano /etc/sysconfig/network-scripts/ifcfg-enp0s9

TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"         # ʹ�þ�̬IP��ַ��Ĭ��Ϊdhcp
IPADDR="192.168.10.10"   # ���õľ�̬IP��ַ
NETMASK="255.255.255.0"    # ��������
GATEWAY="192.168.10.1"    # ���ص�ַ
DNS1="192.168.10.1"       # DNS������
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="ens33"
UUID="95b614cd-79b0-4755-b08d-99f1cca7271b"
DEVICE="ens33"
ONBOOT="yes"             #�Ƿ񿪻�����

reboot
-----------------------------------------------
https://www.cnblogs.com/feiquan/p/9228066.html
https://www.cnblogs.com/nj-duzi/p/13794705.html

#1.�鿴��ǰ����
nmcli connection show


#2.��������enp0s9
nmcli connection add type ethernet con-name enp0s9 ifname enp0s9
nmcli connection show

#��������
nmcli c up enp0s9

#�ر�����
nmcli c down enp0s9


#3.ɾ��ens33����
nmcli connection delete enp0s9


#4.����network����
#systemctl restart network
nmcli c reload




#5.�޸������ļ��е�������
sed -i 's/enp0s8/main/' /etc/sysconfig/network-scripts/ifcfg-main



#6.���������������ļ�
cd /etc/sysconfig/network-scripts
ls
mv ifcfg-main1 ifcfg-eno4

#7.�޸����������ļ�
nano /etc/sysconfig/network-scripts/ifcfg-main
# ��NAME��DEVICE��eno1��Ϊmain 
sed -i 's/main1/eno4/' /etc/sysconfig/network-scripts/ifcfg-eno4



#���������ļ�
\cp /etc/default/grub /etc/default/grub.bak

#�޸������ļ�
sed -i 's/rhgb/net.ifnames=0 &/' /etc/default/grub

#�������������ļ�
grub2-mkconfig -o /boot/grub2/grub.cfg
 
#����ϵͳ��Ч
reboot

