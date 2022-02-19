------------------------------------------------
#查看实际物理内存
dmidecode -t memory | grep Size: | grep -v "No Module Installed"

#查看物理内存分配
dmesg | grep Memory

#查看centos版本
cat /etc/redhat-release




------------------------------------------------
https://www.31du.cn/blog/kill-kdump.html

#关闭kdump
service kdump stop
chkconfig kdump off

#修改文件 /etc/default/grub  将crashkernel改为0M

grub2-mkconfig -o /boot/grub2/grub.cfg 

reboot