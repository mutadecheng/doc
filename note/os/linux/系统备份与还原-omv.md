


#---------------------
#备份 nas os
tar cvpzf /export/nfs/os-nas.tgz --exclude=/root/ssd --exclude=/lost+found --exclude=/sys --exclude=/proc --exclude=/export  --exclude=/mnt --exclude=/srv /
 


#还原 nas os
tar xvpfz /root/ssd/os-nas.tgz -C /root/ssd/D

#创建被排除的目录
mkdir proc
mkdir lost+found
mkdir mnt
mkdir sys

#查看分区uuid
blkid
#修改文件 /etc/fstab , 将分区修改为blkid指令下的UUID





#------------
mount /dev/sda1 /root/ssd/D

#------------
#修复grub引导
> https://blog.csdn.net/weixin_39620279/article/details/116869833

mount /dev/sda1 /mnt

#看下你的设备是不是挂在/mnt目录上
df

mount --bind /proc /mnt/proc
mount --bind /dev /mnt/dev
mount --bind /sys /mnt/sys

chroot /mnt

#恢复grub
grub-install /dev/sda     



#修改/mnt/boot/grub/grub.cfg 文件中的uuid






https://blog.csdn.net/KuXiaoQuShiHuai/article/details/99686620