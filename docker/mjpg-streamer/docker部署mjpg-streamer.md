# docker部署mjpg-streamer(多架构含树莓派)
> https://hub.docker.com/r/lukas1818/mjpg-streamer
> https://gitlab.com/Lukas1818/docker-mjpg-streamer
> http://sourceforge.net/projects/mjpg-streamer/




# 1.查看摄像头硬件
ls /dev/vid*

# 启用摄像头(树莓派)
raspi-config  
Interfacing... -> P1 Camera



# 2.创建容器并运行
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash

#部署(按需修改video编号)
docker run --name=mjpg-streamer --restart=always -d \
-p 10010:8080 --device=/dev/video0:/dev/video0 \
lukas1818/mjpg-streamer mjpg_streamer \
-i "input_uvc.so -n -d /dev/video0 -r 1920x1080" \
-o "output_http.so -w /usr/share/mjpg-streamer/www/ -c admin:admin"


# -i "input_uvc.so -n -d /dev/video0 -r 2592x1944 -f 30 -yuv" \
# -i "input_uvc.so -n -d /dev/video0 -r 1920x1080" \
# -i "input_uvc.so -n -d /dev/video0 -r 640x480 -f 30" \

# -i "input_uvc.so -n -d /dev/video0" -o "output_http.so"

#访问地址
http://192.168.0.153:10010
http://192.168.0.153:10010/?action=snapshot   截图
http://192.168.0.153:10010/?action=stream    动态图像
http://192.168.0.153:10010/javascript_simple.html


```

# 3.容器常用命令

``` bash
#查看容器logs
docker logs mjpg-streamer

#停止容器
docker stop mjpg-streamer

#打开容器
docker start mjpg-streamer

#重启容器
docker restart mjpg-streamer

#删除容器
docker rm mjpg-streamer -f

#进入容器执行命令
docker exec -it mjpg-streamer bash

```


 