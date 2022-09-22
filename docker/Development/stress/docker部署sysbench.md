# docker 压测
> https://blog.csdn.net/weixin_41645135/article/details/126114088 Docker部署及使用压测神器sysbench
> https://www.freesion.com/article/52231508334/
 


# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  
> --env LANG=C.UTF-8  指定系统语言编码避免乱码

``` bash

#创建临时容器
docker run -it --rm severalnines/sysbench sysbench --test=cpu --cpu-max-prime=2000 run


#压测IO
> https://cdn.modb.pro/db/427474 使用sysbench对磁盘进行io性能测试

docker run -it --rm severalnines/sysbench bash
#生成压测文件(会生成128个文件)
sysbench fileio --threads=16 --file-total-size=10G --file-test-mode=rndrw prepare
#压测性能
sysbench fileio --threads=16 --file-total-size=10G --file-test-mode=rndrw run
#清理生成的文件
sysbench fileio --threads=16 --file-total-size=10G --file-test-mode=rndrw cleanup

# 线程数=32 每隔4s输出一次结果 测试时间=60s
# 文件数=10 文件总大小=10G 文件操作模式=随机读写
sysbench --threads=32 --report-interval=4 --time=60 --test=fileio --file-num=10 --file-total-size=10G --file-test-mode=rndrw prepare
sysbench --threads=32 --report-interval=4 --time=60 --test=fileio --file-num=10 --file-total-size=10G --file-test-mode=rndrw run
sysbench --threads=32 --report-interval=4 --time=60 --test=fileio --file-num=10 --file-total-size=10G --file-test-mode=rndrw cleanup


sysbench --threads=1 --report-interval=4 --time=60 --test=fileio --file-num=10 --file-total-size=10G --file-test-mode=rndrw --file-rw-ratio=100 run


```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs stress

#停止容器
docker stop stress

#打开容器
docker start stress

#重启容器
docker restart stress

#删除容器
docker rm stress -f


#进入容器执行命令
docker exec -it stress bash



```


 






