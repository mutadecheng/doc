# docker部署git-client
 
# 1.创建文件夹
> 创建目标文件夹/root/docker/git-client,把部署文件拷贝进去
 


# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash

#创建临时容器执行命令
docker run -it --rm -v /root/git:/root/git serset/git-client bash



cd /root/docker
cd git-client

#精简
docker run --name=git-client --restart=always -d \
-p 10022:10022 \
-v /etc/localtime:/etc/localtime \
serset/git-client


#完整映射
docker run --name=git-client --restart=always -d \
-p 10022:10022 \
-v /etc/localtime:/etc/localtime \
-v $PWD/sshd_config:/etc/ssh/sshd_config \
-v $PWD/git:/root/git \
serset/git-client

```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs git-client

#停止容器
docker stop git-client

#打开容器
docker start git-client

#重启容器
docker restart git-client

#删除容器
docker rm git-client -f


#进入容器执行命令
docker exec -it git-client bash

```




# 4.远程调试
账号 root/123456    
ssh端口 10022 ,可在sshd_config文件中修改


 