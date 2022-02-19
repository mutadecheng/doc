# centos使用证书登录
https://www.cnblogs.com/huxiaoguang/p/10808619.html

mkdir -p /root/.ssh
cd /root/.ssh

#(x.1)生成密钥对(/root/.ssh)  (名称如：home.pem)
ssh-keygen -m PEM -t rsa

#(x.2)下载私钥id_rsa私钥，以备在xshell等工具使用私钥登录


#(x.3)将公钥设置为服务器的登录公钥(按需修改id_rsa.pub)
mv home.pem.pub authorized_keys -f





#(x.4)禁止ssh密码登录
>修改/etc/ssh/sshd_config PasswordAuthentication 改为 no
#重启sshd
systemctl restart sshd


#-----------------------------------------------------
暂不支持此私钥格式,请参考以下方法解决:
1.转换成PEM格式私钥
ssh-keygen -p -m PEM -f 私钥路径
2.生成PEM格式的私钥
生成时增加 -m PEM参数
ssh-keygen -m PEM -t rsa -C "注释"