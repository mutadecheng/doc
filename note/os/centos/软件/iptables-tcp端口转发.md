# iptables做TCP/UDP端口转发
> https://www.cnblogs.com/paul8339/p/14688156.html



#---------------------------
# 开启路由转发功能

# 1、打开包转发功能:
echo 1 > /proc/sys/net/ipv4/ip_forward

#2、修改/etc/sysctl.conf文件，让包转发功能在系统启动时自动生效:
#. Controls IP packet forwarding
net.ipv4.ip_forward = 1


sysctl -w net.ipv4.ip_forward=1


#3、打开iptables的NAT功能
> wlan0 是连接Internet的网卡
/sbin/iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE


#保存iptables的规则
service iptables save


#查看路由表
netstat -rn 
#或
route -n


#----------------------------------
#将本机的端口转发到其他机器
> 转发 本机 192.168.20.3:1103 端口到 192.168.20.20:1120

iptables -t nat -A PREROUTING -p tcp -m tcp --dport 1103 -j DNAT --to-destination 192.168.20.20:1120
iptables -t nat -A POSTROUTING -p tcp -m tcp -d 192.168.20.20 --dport 1120 -j SNAT --to-source 192.168.20.3

#保存
service iptables save

#删除规则(-A改为-D)
iptables -t nat -D PREROUTING -p tcp -m tcp --dport 1103 -j DNAT --to-destination 192.168.20.20:1120
iptables -t nat -D POSTROUTING -p tcp -m tcp -d 192.168.20.20 --dport 1120 -j SNAT --to-source 192.168.20.3

#------------------------------------------------
#删除规则

#查看iptables规则
iptables -t nat -nL --line

#删除规则， -D 并指定序号即可
iptables -t nat -D PREROUTING 2
iptables -t nat -D POSTROUTING 2



