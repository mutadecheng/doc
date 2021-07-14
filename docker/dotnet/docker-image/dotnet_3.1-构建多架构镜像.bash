#构建多架构镜像



#---------------------------------------------------------------------
#(x.1)初始化构建器

#启用 buildx 插件
export DOCKER_CLI_EXPERIMENTAL=enabled

#验证是否开启
docker buildx version

#启用 binfmt_misc
docker run --rm --privileged docker/binfmt:66f9012c56a8316f9244ffd7622d7c21c1f6f28d

#验证是 binfmt_misc 否开启
ls -al /proc/sys/fs/binfmt_misc/


#创建一个新的构建器
docker buildx create --use --name mybuilder

#启动构建器
docker buildx inspect mybuilder --bootstrap

#查看当前使用的构建器及构建器支持的 CPU 架构，可以看到支持很多 CPU 架构
docker buildx ls



#---------------------------------------------------------------------
#(x.2)构建支持arm、arm64和amd64多架构的Docker镜像，并推送到Docker Hub

#若失败则可先尝试逐个平台构建
#把本文件所在目录下的文件夹拷贝到image
# cd /root/image

#登录
# docker login -u serset -p xxxxxxx


#get version
version=`docker run -i --rm mcr.microsoft.com/dotnet/runtime:3.1 dotnet --info | grep Version`
version=`echo ${version#*:} | sed 's/ //g'`
echo $version




cd dotnet_aspnet-3.1
docker buildx build \
-t serset/dotnet:aspnet-3.1 -t serset/dotnet:aspnet-$version \
-t serset/dotnet:3.1 \
--platform=linux/arm/v7,linux/arm64,linux/amd64 . --push
cd ..


cd dotnet_runtime-3.1
docker buildx build -t serset/dotnet:runtime-3.1 -t serset/dotnet:runtime-$version --platform=linux/arm/v7,linux/arm64,linux/amd64 . --push
cd ..


cd dotnet_sdk-3.1
docker buildx build -t serset/dotnet:sdk-3.1 -t serset/dotnet:sdk-$version --platform=linux/arm/v7,linux/arm64,linux/amd64 . --push
cd ..





#--------------------------------------------------------------------- 
#删除镜像
# docker rmi --force $(docker images | grep dotnet | awk '{print $3}')
