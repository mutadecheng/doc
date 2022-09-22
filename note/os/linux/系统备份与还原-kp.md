



#---------------------
#备份 os
tar cvpzf /root/nfs/os-kp.tgz --exclude=/root/nfs --exclude=/lost+found --exclude=/sys --exclude=/proc --exclude=/mnt --exclude=/srv /
 

#---------------------
#还原 os
mount /dev/sda1 /mnt

rm -rf /mnt/*

tar xvpfz /root/ssd/os-kp.tgz -C /mnt

#创建被排除的目录
cd /mnt
mkdir proc
mkdir lost+found
mkdir mnt
mkdir sys

#查看分区uuid
blkid
#修改文件 /etc/fstab , 将分区修改为blkid指令下的UUID
> https://www.lmlphp.com/user/57857/article/item/1466475/
/dev/sda1: UUID="de6bd1b3-e3d8-436c-84d0-ea16d251f3ea" TYPE="ext4" PARTUUID="c84f490e-01"


#---------------------
#修复grub2的引导
> http://t.zoukankan.com/fangying7-p-4372664.html 
mount /dev/sda1 /mnt

mount --bind /proc /mnt/proc
mount --bind /dev /mnt/dev
mount --bind /sys /mnt/sys
  


#切换root到我的硬盘
chroot /mnt 

#安装grub2到我的/deb/sda上，即硬盘的MBR上（主分区的第一个sector）
grub2-install --recheck /dev/sda --target i386-pc

#重新生成配置文件
grub2-mkconfig -o /boot/grub2/grub.cfg



#---------------------
