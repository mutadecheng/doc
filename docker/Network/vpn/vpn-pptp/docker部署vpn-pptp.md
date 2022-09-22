# docker部署
> https://my.oschina.net/u/4315736/blog/4070487
> https://www.cnblogs.com/smallcoderhujin/p/4485026.html
> 点对点隧道协议（PPTP） 1723 

--------------------------------------
# 1.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash


# (x.1)创建secrets文件
mkdir -p /root/docker/vpn-pptp
cd /root/docker/vpn-pptp
echo "# Secrets for authentication using CHAP
# client        server  secret                  IP addresses
lith    *      Admin0123    10.99.99.100
" > chap-secrets



# (x.2)创建容器
cd /root/docker/vpn-pptp
docker run --restart=always -d --privileged \
--name vpn-pptp \
--net=host \
-v $PWD/chap-secrets:/etc/ppp/chap-secrets \
saved/vpn-pptp



```


--------------------------------------
# 2.windows登录vpn:  
  1.打开vpn settings -> Add a VPN connection
      Server name:	填写vpn服务器的ip或者域名
      VPN type:		PPTP
      Type of sign-in:  Username and password
      Username:		lith
      Password:		Admin0123
  2.在添加的vpn项下点击 Connect,连接成功即可



--------------------------------------
# 3.指定ip地址池

# (x.1)创建配置文件/etc/pptpd.conf
cd /root/docker/vpn-pptp

echo "option /etc/ppp/pptpd-options
#debug
#stimeout 10
logwtmp
#bcrelay eth1
#delegate
#connections 100
localip 10.99.99.1
remoteip 10.99.99.100-200
" > pptpd.conf

# (x.2)在创建容器时指定文件映射
-v $PWD/pptpd.conf:/etc/pptpd.conf \


--------------------------------------
# 4.容器常用命令

``` bash
#查看容器logs
docker logs vpn-pptp

#停止容器
docker stop vpn-pptp

#打开容器
docker start vpn-pptp

#重启容器
docker restart vpn-pptp

#删除容器
docker rm vpn-pptp -f

#进入容器执行命令
docker exec -it vpn-pptp bash

```


--------------------------------------
# 5.迁移镜像

``` bash
# 备份docker镜像
# docker login -u saved -p xxx
docker pull mobtitude/vpn-pptp
docker tag mobtitude/vpn-pptp saved/vpn-pptp
docker push saved/vpn-pptp
```