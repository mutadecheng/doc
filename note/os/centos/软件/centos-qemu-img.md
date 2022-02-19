# 通过qemu-img工具转换镜像格式
> https://support.huaweicloud.com/bestpractice-ims/ims_bp_0030.html


# 安装qemu-img
yum update -y
yum install qemu-img -y


# 验证安装
qemu-img --help



# 转换vhd为qcow2
qemu-img convert -p -f vpc -O qcow2 /root/temp/c8Mini_k8s.vhd /root/temp/c8Mini_k8s.qcow2

# 转换qcow2为vhd
qemu-img convert -p -f qcow2 -O vpc /root/temp/c8Mini_k8s.qcow2 /root/temp/c8Mini_k8s_2.vhd



#查询转换后的qcow2格式镜像文件的详细信息
qemu-img info /root/temp/c8Mini_k8s.qcow2


