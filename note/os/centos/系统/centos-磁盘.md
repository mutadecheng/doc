﻿------------------------------------------------------------------------------------
#手动挂载磁盘
https://baijiahao.baidu.com/s?id=1611865194036930153&wfr=spider&for=pc
https://www.cnblogs.com/myvic/p/6816924.html

#查看磁盘列表
fdisk -l


#挂载磁盘。这里需要我们提前创建好后面挂载的目录，比如 /home/homework/data
mkdir -p /root/vhd
mount  /dev/sdb1  /root/vhd

#卸载磁盘
umount  /dev/sdb1

 
#查询当前服务器所有的硬盘。
ll /dev/disk/by-path



#查看磁盘挂载情况
lsblk
lsblk -f 


------------------------------------------------------------------------------------
#挂载ntfs分区
https://blog.csdn.net/baidu_41617231/article/details/90666474

#加源
yum install wget -y
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

#安装ntfs支持
yum update
yum install ntfs-3g -y



#挂载NTFS分区
mkdir /root/ntfs
mount -t ntfs-3g /dev/sdc2  /root/ntfs




#---------------------------------------------------
#开机自动挂载硬盘
> https://blog.csdn.net/tangjuntangjun/article/details/84635259
设备的顺序编码在关闭或者开启服务器过程中可能发生改变，例如/dev/sdb1可能会变成/dev/sdb2。
推荐使用UUID来配置自动挂载数据盘。
磁盘的UUID（universally unique identifier）是Linux系统为存储设备提供的唯一的标识字符串。

#查询磁盘分区的UUID
blkid /dev/sda1
# /dev/sda1: LABEL="k-data" UUID="79644d30-814a-4c01-9e27-88536197c546" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="6e46ff1a-01"

#编辑文件/etc/fstab，在文件末尾添加一行
UUID=79644d30-814a-4c01-9e27-88536197c546 /srv/k-data ext4 defaults 0 0

#参数解释：
UUID=bb84333a-6a0d-4285-a14c-cf8b5da88d61：要挂载的磁盘分区的UUID
/home/eason/data：挂载目录
ext4：分区格式为ext4
defaults：挂载时所要设定的参数(只读，读写，启用quota等)，输入defaults包括的参数有(rw、dev、exec、auto、nouser、async)
0：使用dump是否要记录，0为不需要，1为需要
2：2是开机时检查的顺序，boot系统文件为1，其他文件系统都为2，如不要检查就为0


------------------------------------------------------------------------------------
#查看磁盘

查看磁盘使用情况
df -hl
 
查看文件夹所有者权限命令
ls -lt

例如：
-rwxr-xr-x 1 abc staff 39 9 27 09:43 command.sh
abc就是拥有者
staff就是组用户

------------------------------------------------------------------------------------
#软链接

#将已存在的文件夹 /usr/a/node 映射到 /usr/b/node
ln -s /usr/a/node /usr/b/node

#删除软链接
rm -rf /usr/b/node

------------------------------------------------------------------------------------
# parted 磁盘分区
> https://www.cnblogs.com/my-show-time/p/15260739.html
> https://blog.csdn.net/ora_g/article/details/107046047

#安装
apt-get install parted

#指定磁盘进行分区
parted /dev/sda
#创建gpt分区表
mklabel gpt
#查看分区表信息
print

#一键分区(分区名称 文件系统格式 起始位置 结束位置)
mkpart fun4t ext4 0% 100%

#交互式分区
(parted) mkpart                                                           
Partition name?  []? fun4t                                                
File system type?  [ext2]? ext4                                           
Start? 0%                                                                 
End? 100%                                                                 
(parted) print

#退出
quit

------------------------------------------------------------------------------------
#fdisk 磁盘分区
https://www.jianshu.com/p/46602774e7ca

fdisk /dev/sda

常用命令： 
n：创建新分区 
d：删除已有分区
 t：修改分区类型
 l：查看所有支持的类型
 p：显示现有分区信息 
w：保存并退出
 q：不保存并退出 
m：查看帮助信息


------------------------------------------------------------------------------------
#磁盘格式化

#查看 mkfs 支持的文件格式
mkfs[tab][tab]

#创建Ext3文件系统
mkfs -t ext3 /dev/sdb

#创建Ext4文件系统
mkfs.ext4 /dev/sda1
#mkfs -t ext4 /dev/sdc1


------------------------------------------------------------------------------------
# 挂载磁盘报错：can't read superblock
> https://www.jianshu.com/p/933f1b88c421
> 意外断电造成mount挂载硬盘报错
## 修复方法
fdisk -l
fsck -y /dev/sdb1



------------------------------------------------------------------------------------
# 获取磁盘读写状态

yum install sysstat

iostat -dm

#输出运行中的磁盘
IFS=$'\n'
for line in `iostat -dm`;
do  
	echo $line | awk '{if ( $3~/^([0-9\.])+$/ && $3>0 && $4>=0) print $1}'
done

#输出运行中的磁盘
for disk in `iostat -dm | awk '{if ( $3~/^([0-9\.])+$/ && $3>0 && $4>=0) print $1}'`;
do  
	echo $disk
done



------------------------------------------------------------------------------------
# smart
> https://blog.csdn.net/carefree2005/article/details/120718994 Linux命令之smartctl命令
> https://blog.csdn.net/labkill/article/details/119849857  硬盘SMART检测参数详解

#输出所有磁盘
smartctl --scan

#输出磁盘温度
smartctl  -a /dev/sda |grep -i Temperature_Celsius | awk '{print $10}'

#输出所有磁盘的温度
for diskName in $(smartctl --scan | awk '{print $1}')
do
	#echo $diskName
	echo "$diskName $(smartctl -a $diskName |grep -i Temperature_Celsius |awk '{print $10}')"
done


#输出运行中磁盘的温度
for disk in `iostat -dm | awk '{if ( $3~/^([0-9\.])+$/ && $3>0 && $4>=0) print $1}'`;
do  
	echo "node_disk_temperature_now{device=\"$disk\"} $(smartctl -a /dev/$disk |grep -i Temperature_Celsius |awk '{print $10}')"
done