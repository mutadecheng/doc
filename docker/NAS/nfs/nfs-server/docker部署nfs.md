# docker部署svn服务器
> 參考 https://blog.csdn.net/pingweicheng/article/details/108569848
 
#-------------------------------------------------
#(x.1)服务端

mkdir -p /root/docker/nfs/data

#创建容器
docker run -d --privileged  \
--name nfs \
-v /root/docker/nfs/data:/nfs \
-e NFS_EXPORT_DIR_1=/nfs \
-e NFS_EXPORT_DOMAIN_1=\172.19.58.224 \
-e NFS_EXPORT_OPTIONS_1=rw,insecure,no_subtree_check,no_root_squash,fsid=1 \
-p 111:111 -p 111:111/udp \
-p 2049:2049 -p 2049:2049/udp \
-p 32765:32765 -p 32765:32765/udp \
-p 32766:32766 -p 32766:32766/udp \
-p 32767:32767 -p 32767:32767/udp \
fuzzle/docker-nfs-server



#-------------------------------------------------
#(x.2)客户端

#安装rpcbind服务
yum -y install rpcbind


#挂载 
mount -v -t nfs -o nolock,nfsvers=3,proto=udp,port=2049 i.ali.sers.cloud:/nfs /root/nfs/data/


#查看挂载结果
df -h

#解除挂载
umount /root/nfs/data/




#3.查看服务端已共享的目录
yum install showmount -y
showmount -e ali.sers.cloud




