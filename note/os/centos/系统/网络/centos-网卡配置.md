-----------------------------------------------
#创建网卡

#1.查看当前网卡
ifconfig
nmcli connection show
 
#2.创建配置enp0s8
nmcli connection add type ethernet con-name enp0s8 ifname enp0s8
nmcli connection show

#3.启用网卡enp0s8
ifup enp0s8

-----------------------------------------------

#配置静态ip
ifconfig

#创建配置
nmcli connection add type ethernet con-name enp0s9 ifname enp0s9
#nmcli connection show 
#nmcli connection delete enp0s9

#修改网卡配置文件
nano /etc/sysconfig/network-scripts/ifcfg-enp0s9

TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"         # 使用静态IP地址，默认为dhcp
IPADDR="192.168.10.10"   # 设置的静态IP地址
NETMASK="255.255.255.0"    # 子网掩码
GATEWAY="192.168.10.1"    # 网关地址
DNS1="192.168.10.1"       # DNS服务器
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
ONBOOT="yes"             #是否开机启用

reboot
-----------------------------------------------
https://www.cnblogs.com/feiquan/p/9228066.html
https://www.cnblogs.com/nj-duzi/p/13794705.html

#1.查看当前网卡
nmcli connection show


#2.创建配置enp0s9
nmcli connection add type ethernet con-name enp0s9 ifname enp0s9
nmcli connection show

#启用网卡
nmcli c up enp0s9

#关闭网卡
nmcli c down enp0s9


#3.删除ens33连接
nmcli connection delete enp0s9


#4.重启network服务
#systemctl restart network
nmcli c reload




#5.修改配置文件中的网卡名
sed -i 's/enp0s8/main/' /etc/sysconfig/network-scripts/ifcfg-main



#6.重命名网卡配置文件
cd /etc/sysconfig/network-scripts
ls
mv ifcfg-main1 ifcfg-eno4

#7.修改网卡配置文件
nano /etc/sysconfig/network-scripts/ifcfg-main
# 将NAME和DEVICE由eno1改为main 
sed -i 's/main1/eno4/' /etc/sysconfig/network-scripts/ifcfg-eno4



#备份配置文件
\cp /etc/default/grub /etc/default/grub.bak

#修改配置文件
sed -i 's/rhgb/net.ifnames=0 &/' /etc/default/grub

#重新生成启动文件
grub2-mkconfig -o /boot/grub2/grub.cfg
 
#重启系统生效
reboot

