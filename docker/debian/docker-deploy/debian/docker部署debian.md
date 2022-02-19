# docker部署opencv
 

#1. 拷贝本文件夹
>可通过修改 /root/app/startup.sh 文件 改变配置

``` bash
# startup.sh

# run on back
#chmod 777 "/root/app/app.bash"
#sh "/root/app/app.bash" > /root/app/app.log 2>&1 &

# run on front 
#cd /root/app 
#python3 detector.py


# run on front
while [ 1 -lt 2 ]
do
	sleep 3600
done

 
```




#2. 创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash
cd /root/docker/debian

docker run --name=debian --restart=always --net=host -d -v $PWD:/root/app debian bash -c 'chmod +x /root/app/startup.sh;sh /root/app/startup.sh;'



```

#3. 应用已经运行


-----------------------------


``` bash
#常用命令

#查看容器logs
docker logs debian

#在容器内执行命令行
docker exec -it debian bash

#停止容器
docker stop debian

#打开容器
docker start debian

#重启容器
docker restart debian

#删除容器
docker rm debian -f

```
