



#-----------------------------------------------------------
#(x.1)安装图形桌面软件
# 安装图形桌面软件，包约1个G，时间大约是3分钟
yum groupinstall "Server with GUI" --allowerasing -y

# 启动图形桌面软件
startx



# run on back
nohup startx &

#---------------------------------------------------
# VNC
> https://www.cnblogs.com/afei654138148/p/14934207.html
> https://www.cnblogs.com/xs233/p/13684527.html

#(x.x.1)安装 VNC Server
yum install tigervnc-server tigervnc-server-module -y 

#(x.x.2)修改配置文件添加用户
> /etc/tigervnc/vncserver.users
# :2=andrew
# :3=lisa
:1=root

#(x.x.3)启动vncserver
systemctl daemon-reload
systemctl start vncserver@:1.service


#(x.x.4)查看VNCServer是否启动
nc -zv localhost 5901


#(x.x.5)按需关闭防火墙
systemctl status firewalld
systemctl stop firewalld



#---------------------------------------------------
# 使用Windows自带远程桌面应用连接CentOS8远程桌面
> https://www.cnblogs.com/sinferwu/p/13741036.html

#检查是否安装epel库
rpm -qa|grep epel

#按需安装epel库
yum install epel-release -y

#安装xrdp
yum install xrdp -y

#Xrdp最终会自动启用VNC，所以必须安装tigervnc-server
#yum install tigervnc-server -y


#启动XRDP服务命令
> 启动后即可使用mstsc连接
systemctl start xrdp




