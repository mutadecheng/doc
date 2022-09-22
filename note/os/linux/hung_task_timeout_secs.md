# Linux系统出现hung_task_timeout_secs和blocked for more than 120 seconds的解决方法
> https://blog.csdn.net/weixin_44410537/article/details/98449706
> https://www.cnblogs.com/zhengchunyuan/p/10019502.html

#-----------
#修改文件 /etc/sysctl.conf ，加入如下两行 并重启
# cat /etc/sysctl.conf 
vm.dirty_background_ratio = 5
vm.dirty_ratio = 10

#使其立即生效
sysctl -p


#查看内存脏数据
cat /proc/vmstat | egrep "dirty|writeback"



