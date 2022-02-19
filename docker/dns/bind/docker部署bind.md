# docker部署
> https://hub.docker.com/r/sameersbn/bind
> https://www.jianshu.com/p/c9e376df7074
> https://blog.csdn.net/qq_30442207/article/details/114971723
> https://zhuanlan.zhihu.com/p/58730472

# 1.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

 

``` bash
# 创建容器(不开放管理页面)
docker run --restart=always -d \
--name bind \
-p 53:53/tcp -p 53:53/udp \
-v /root/docker/bind:/data \
-e WEBMIN_ENABLED=false \
sameersbn/bind:9.16.1-20200524



#创建临时容器
docker run -it --rm \
-p 53:53/tcp -p 53:53/udp \
-v /root/docker/bind:/data \
-v /root/docker/bind/log:/var/cache/bind \
-e WEBMIN_ENABLED=false \
sameersbn/bind:9.16.1-20200524

# 创建临时容器(开放管理页面)
docker run -it --rm \
-p 53:53/tcp -p 53:53/udp -p 10010:10000/tcp \
-v /root/docker/bind:/data \
sameersbn/bind:9.16.1-20200524

#管理页面地址 
https://ali.sers.cloud:10010
root/password


#不启用管理页面
--env WEBMIN_ENABLED=false
#指定管理页面密码
--env ROOT_PASSWORD=password





docker rm -f bind

docker restart bind

docker logs bind


 
#更新配置文件
#rndc reload zonename
docker exec -it bind rndc reload lith.cloud


#检查配置文件是否有错
docker exec -it bind named-checkconf


``` 

#--------------------
为使该DNS服务器生效，还需要到 lith.cloud 当前DNS添加如下A记录 （如果该DNS服务器用来解析 lith.cloud，请务必在 dns.lith.cloud 服务器上添加如下A记录）。更多帮助。

DNS 服务器	记录类型	IP 地址
dns.lith.cloud	A	47.116.132.117



#--------------------
# dig查看域名解析

# centos安装dig
yum install bind-utils -y

#树莓派安装dig
apt-get install dnsutils -y


dig(选项)(参数)

@<服务器地址>：指定进行域名解析的域名服务器；
-b：当主机具有多个IP地址，指定使用本机的哪个IP地址向域名服务器发送域名查询请求； 
-f<文件名称>：指定dig以批处理的方式运行，指定的文件中保存着需要批处理查询的DNS任务信息； 
-P：指定域名服务器所使用端口号； 
-t<类型>：指定要查询的DNS数据类型；
-x：执行逆向域名查询； 
-4：使用IPv4； 
-6：使用IPv6； 
-h：显示指令帮助信息。

# 查看域名解析
dig @127.0.0.1 pan.home.lith.cloud

dig @ali.sers.cloud pan.home.lith.cloud


dig @ali.sers.cloud be.lith.cloud
dig be.lith.cloud
#--------------------
# nslookup查看域名解析
>nslookup domain [dns-server]

nslookup pan.home.lith.cloud ali.sers.cloud
nslookup pan.home.lith.cloud

#--------------------
# 测试

docker run -it centos:7

# 这里的IP地址使用你的bind容器IP替换
echo "nameserver 47.116.132.117" > /etc/resolv.conf
ping ttt.lith.cloud



#--------------------
# 智能匹配
# 同一域名基于源ip地址分配给不同ip的dns配置
> https://www.cnblogs.com/everSeeker/p/5263012.html
> https://blog.csdn.net/weixin_40460156/article/details/81608687
> https://blog.csdn.net/zhu_tianwei/article/details/45104125

view "home" {
    match-clients {
        47.116.132.117;
    };
    zone "lith.cloud" {
	type master;
	file "/var/lib/bind/home.lith.cloud.hosts";
    };
};

view "internet" {
    match-clients {
        any;
    };
    zone "lith.cloud" {
	type master;
	file "/var/lib/bind/lith.cloud.hosts";
    };
};




#--------------------
# 输出日志
> https://www.cnblogs.com/fjping0606/p/4428736.html
#把以下语句添加到named.conf
logging {
      channel query_log {
	      file "query.log" versions 3 size 20m;
	      severity info;
	      print-time yes;
	      print-category  yes;
      };
      category queries {
	      query_log;
      };
};

#这样服务器会在工作目录（directory语句所指定的目录，通常为：/var/cache/bind）下创建query.log这个文件，并把运行过程产生的queries消息写如到query.log文件中，如下：
Nov   28  16:04:55.516  queries: client 192.168.0.113#32770: query: dns.andy.com IN A