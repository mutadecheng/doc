# docker部署ubuntu
 
# 1.创建文件夹
> 创建文件目标文件夹/root/docker/ubuntu,把部署文件拷贝进去  
> 创建 startup.sh 文件并指定启动命令(按实际情况修改)  

``` bash
# /root/app/startup.sh

# run on back
# sh /root/app/App2.sh > /root/app/App2.log 2>&1 &

# run on front
sh /root/app/ubuntu.sh > /root/app/ubuntu.log 2>&1

# run on front
# while [ 1 -lt 2 ]
# do
# 	sleep 3600
# done

```


# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash
cd /root/docker
cd dotnet_debug-2.1

#精简
docker run --name=ubuntu --restart=always -d \
--net=host \
-v /etc/localtime:/etc/localtime \
ubuntu


#完整映射

 
docker  exec -it ubuntu bash

 apt-get update 
 apt-get -y install openssh-server

 
RUN echo "root:123456" | chpasswd

 service ssh restart

docker rm ubuntu -f

docker run --name=ubuntu --restart=always -d \
--net=host \
-v /etc/localtime:/etc/localtime \
-v $PWD/sshd_config:/etc/ssh/sshd_config \
-v $PWD/startup.sh:/root/app/startup.sh \
-v $PWD:/root/app \
ubuntu:20.04 bash -c 'sleep 3600'

```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs ubuntu

#停止容器
docker stop ubuntu

#打开容器
docker start ubuntu

#重启容器
docker restart ubuntu

#删除容器
docker rm ubuntu -f


#进入容器执行命令
docker  exec -it ubuntu bash

```




# 4.远程调试
账号 root/123456    
ssh端口 10022 ,可在sshd_config文件中修改


  (x.x.1)Visual Studio 调试 -> 附加到进程    
  (x.x.2)连接类型选择 SSH    
  (x.x.3)输入连接目标 点击回车连接    
  (x.x.4)在可用进程中选择 需要调试的进程 （可用 dotnet筛选进程）点击附加    
  (x.x.5) 弹框 选择  Managed(.NET Core for Unix)  点击 OK    
  (x.x.6)稍等片刻 即可进入远程断点调试了    
