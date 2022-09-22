# 跨平台构建 Docker 镜像，x86、arm
> https://docs.docker.com/engine/reference/commandline/buildx/
> https://blog.csdn.net/alex_yangchuansheng/article/details/103146303
> https://www.latelee.org/docker/armdocker-cross-comiple-for-arm-on-x86.html


#----------------------------------------------------------------------------
#启用 buildx 插件

#开启实验特性 
export DOCKER_CLI_EXPERIMENTAL=enabled

#验证是否开启
docker buildx version

#启用binfmt_misc
docker run --rm --privileged docker/binfmt:66f9012c56a8316f9244ffd7622d7c21c1f6f28d

#验证binfmt_misc是否开启
ls -al /proc/sys/fs/binfmt_misc/



#查看构建器是否存在
if [ "$(docker buildx ls | grep mybuilder)" ]; then echo 'already exist'; else echo 'not exist'; fi

#创建构建器
#docker buildx create --use --name mybuilder
if [ ! "$(docker buildx ls | grep mybuilder)" ]; then docker buildx create --use --name mybuilder; fi

#启动构建器
docker buildx inspect mybuilder --bootstrap

#查看当前使用的构建器及构建器支持的 CPU 架构，可以看到支持很多 CPU 架构：
docker buildx ls



#----------------------------------------------------------------------------
#使用buildx构建arm架构的Docker镜像 
cd /home/ec2-user/image 
docker buildx build -t serset/raspi_opencv --platform=linux/arm/v7 -o type=docker .



#构建支持 arm、arm64 和 amd64 多架构的 Docker 镜像，同时将其推送到 Docker Hub
docker login -u serset -p xxxxxxxxx
cd /home/ec2-user/image 
docker buildx build -t serset/opencv  --platform=linux/arm/v7,linux/arm64,linux/amd64 . --push
 
 

#----------------------------------------------------------------------------
#构建结束后 移除构建器
#docker buildx rm mybuilder -f;
if [ "$(docker buildx ls | grep mybuilder)" ]; then docker buildx rm mybuilder; fi








