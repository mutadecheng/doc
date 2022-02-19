
https://www.cnblogs.com/xs233/p/13684527.html


#(x.1)安装图形桌面软件
# 安装图形桌面软件，包约1个G，时间大约是3分钟
yum groupinstall "Server with GUI" --allowerasing -y

# 启动图形桌面软件
startx








#(x.2)安装 VNC Server
yum install tigervnc-server tigervnc-server-module -y 

#配置VNC服务端的密码
> Would you like to enter a view-only password (y/n)?：是否创建一个只读用户  ， 输入 n  回车
vncpasswd


#启动vncserver
systemctl start vncserver@:1





#(x.3)使用Windows自带远程桌面应用连接CentOS8远程桌面
> https://www.cnblogs.com/sinferwu/p/13741036.html

#检查是否安装epel库
rpm -qa|grep epel

#按需安装epel库
yum install epel-release

#安装xrdp
yum install xrdp

#Xrdp最终会自动启用VNC，所以必须安装tigervnc-server
yum install tigervnc-server


#启动XRDP服务命令
> 启动后即可使用mstsc连接
systemctl start xrdp




