# docker部署emsdk
> https://emscripten.org/docs/getting_started/downloads.html#using-the-docker-image



# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash

#创建临时容器
cd /root/docker/emsdk
docker run -it --rm \
-v /etc/localtime:/etc/localtime \
-v $PWD:/src \
-u $(id -u):$(id -g) \
emscripten/emsdk bash

#
emcc
node -v



emcc tests/hello_world.c -o hello.html

```




 






