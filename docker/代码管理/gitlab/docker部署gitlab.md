# docker部署gitlab
> https://docs.gitlab.com/ee/install/docker.html
> https://zhuanlan.zhihu.com/p/63786567
> https://www.cnblogs.com/diaomina/p/12830449.html


# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

``` bash

 
#创建容器
mkdir -p /root/docker/gitlab
cd /root/docker/gitlab
docker run --restart=always -d \
--name gitlab \
--shm-size 256m \
--hostname gitlab.lith.cloud \
-p 10443:443 -p 10080:80 -p 10022:22 \
-v /etc/localtime:/etc/localtime \
-v $PWD/config:/etc/gitlab \
-v $PWD/logs:/var/log/gitlab \
-v $PWD/data:/var/opt/gitlab \
gitlab/gitlab-ce:14.6.2-ce.0


#获取root密码
docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password

#登录
http://192.168.20.20:10080
https://192.168.20.20:10443
root/SWP9t3fec8X3czz0i0dlcfDE9KYgJk7b4LrTVlsSnjE=

```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs gitlab

#停止容器
docker stop gitlab

#打开容器
docker start gitlab

#重启容器
docker restart gitlab

#删除容器
docker rm gitlab -f


#进入容器执行命令
docker exec -it gitlab bash



```


 


#------------------------------------------
# 4.优化

#(1)禁用gravatar头像（www.gravatar.com）
Settings -> General -> Account and limit -> uncheck "Gravatar enabled" -> save


# (2)内存优化
> https://www.jianshu.com/p/2a7f0022cf8b
> gitlab/config/gitlab.rb

# 关闭业务监控
prometheus_monitoring['enable'] = false
puma['enable'] = true
puma['worker_timeout'] = 60
# 进程数（最低2，默认cpu核数+1）
puma['worker_processes'] = 2
puma['per_worker_max_memory_mb'] = 300
# sidekiq并发数
sidekiq['concurrency'] = 16
# 数据库缓存大小
postgresql['shared_buffers'] = "256MB"
# 数据库并发数
postgresql['max_worker_processes'] = 8


#重新加载配置
docker exec -it gitlab gitlab-ctl reconfigure