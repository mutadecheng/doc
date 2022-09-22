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

#把本文件所在目录下的文件夹拷贝到image


#登录
# docker login -u serset -p xxxxxxx

# cd /root/image

 

#---------------------------------------------------------------------
# (x.3)构建多架构镜像-aspnet

# (x.x.1)分架构创建镜像

#构建镜像
cd dotnet_aspnet-2.1-amd64
docker buildx build -t serset/dotnet:aspnet-2.1-amd64 --platform=linux/amd64 -o type=docker .
cd ..

cd dotnet_aspnet-2.1-arm
docker buildx build -t serset/dotnet:aspnet-2.1-arm64 --platform=linux/arm64 -o type=docker .
docker buildx build -t serset/dotnet:aspnet-2.1-arm --platform=linux/arm/v7 -o type=docker .
cd ..

#推送到镜像服务器
docker push serset/dotnet:aspnet-2.1-amd64
docker push serset/dotnet:aspnet-2.1-arm64
docker push serset/dotnet:aspnet-2.1-arm


# (x.x.2)创建 manifest
#创建 manifest 列表
docker manifest rm serset/dotnet:aspnet-2.1
docker manifest create serset/dotnet:aspnet-2.1 serset/dotnet:aspnet-2.1-amd64 serset/dotnet:aspnet-2.1-arm64 serset/dotnet:aspnet-2.1-arm

#设置 manifest 列表
docker manifest annotate serset/dotnet:aspnet-2.1 serset/dotnet:aspnet-2.1-amd64 --os linux --arch amd64
docker manifest annotate serset/dotnet:aspnet-2.1 serset/dotnet:aspnet-2.1-arm64 --os linux --arch arm64
docker manifest annotate serset/dotnet:aspnet-2.1 serset/dotnet:aspnet-2.1-arm --os linux --arch arm

#查看 manifest 列表
docker manifest inspect serset/dotnet:aspnet-2.1

#推送manifest到镜像服务器
docker manifest push serset/dotnet:aspnet-2.1



#---------------------------------------------------------------------
# (x.4)构建多架构镜像-runtime

# (x.x.1)分架构创建镜像

#构建镜像
cd dotnet_runtime-2.1-amd64
docker buildx build -t serset/dotnet:runtime-2.1-amd64 --platform=linux/amd64 -o type=docker .
cd ..

cd dotnet_runtime-2.1-arm
docker buildx build -t serset/dotnet:runtime-2.1-arm64 --platform=linux/arm64 -o type=docker .
docker buildx build -t serset/dotnet:runtime-2.1-arm --platform=linux/arm/v7 -o type=docker .
cd ..

#推送到镜像服务器
docker push serset/dotnet:runtime-2.1-amd64
docker push serset/dotnet:runtime-2.1-arm64
docker push serset/dotnet:runtime-2.1-arm


# (x.x.2)创建 manifest
#创建 manifest 列表
docker manifest rm serset/dotnet:runtime-2.1
docker manifest create serset/dotnet:runtime-2.1 serset/dotnet:runtime-2.1-amd64 serset/dotnet:runtime-2.1-arm64 serset/dotnet:runtime-2.1-arm

#设置 manifest 列表
docker manifest annotate serset/dotnet:runtime-2.1 serset/dotnet:runtime-2.1-amd64 --os linux --arch amd64
docker manifest annotate serset/dotnet:runtime-2.1 serset/dotnet:runtime-2.1-arm64 --os linux --arch arm64
docker manifest annotate serset/dotnet:runtime-2.1 serset/dotnet:runtime-2.1-arm --os linux --arch arm

#查看 manifest 列表
docker manifest inspect serset/dotnet:runtime-2.1

#推送manifest到镜像服务器
docker manifest push serset/dotnet:runtime-2.1




#---------------------------------------------------------------------
# (x.5)构建多架构镜像-sdk

# (x.x.1)分架构创建镜像

#构建镜像
cd dotnet_sdk-2.1-amd64
docker buildx build -t serset/dotnet:sdk-2.1-amd64 --platform=linux/amd64 -o type=docker .
cd ..

cd dotnet_sdk-2.1-arm
docker buildx build -t serset/dotnet:sdk-2.1-arm64 --platform=linux/arm64 -o type=docker .
docker buildx build -t serset/dotnet:sdk-2.1-arm --platform=linux/arm/v7 -o type=docker .
cd ..

#推送到镜像服务器
docker push serset/dotnet:sdk-2.1-amd64
docker push serset/dotnet:sdk-2.1-arm64
docker push serset/dotnet:sdk-2.1-arm


# (x.x.2)创建 manifest
#创建 manifest 列表
docker manifest rm serset/dotnet:sdk-2.1
docker manifest create serset/dotnet:sdk-2.1 serset/dotnet:sdk-2.1-amd64 serset/dotnet:sdk-2.1-arm64 serset/dotnet:sdk-2.1-arm

#设置 manifest 列表
docker manifest annotate serset/dotnet:sdk-2.1 serset/dotnet:sdk-2.1-amd64 --os linux --arch amd64
docker manifest annotate serset/dotnet:sdk-2.1 serset/dotnet:sdk-2.1-arm64 --os linux --arch arm64
docker manifest annotate serset/dotnet:sdk-2.1 serset/dotnet:sdk-2.1-arm --os linux --arch arm

#查看 manifest 列表
docker manifest inspect serset/dotnet:sdk-2.1

#推送manifest到镜像服务器
docker manifest push serset/dotnet:sdk-2.1




#---------------------------------------------------------------------
# (x.6)构建默认镜像

#创建 manifest 列表
docker manifest rm serset/dotnet:2.1
docker manifest create serset/dotnet:2.1 serset/dotnet:aspnet-2.1-amd64 serset/dotnet:aspnet-2.1-arm64 serset/dotnet:aspnet-2.1-arm

#设置 manifest 列表
docker manifest annotate serset/dotnet:2.1 serset/dotnet:aspnet-2.1-amd64 --os linux --arch amd64
docker manifest annotate serset/dotnet:2.1 serset/dotnet:aspnet-2.1-arm64 --os linux --arch arm64
docker manifest annotate serset/dotnet:2.1 serset/dotnet:aspnet-2.1-arm --os linux --arch arm

#查看 manifest 列表
docker manifest inspect serset/dotnet:2.1

#推送manifest到镜像服务器
docker manifest push serset/dotnet:2.1


#--------------------------------------------------------------------- 
#删除镜像
# docker rmi --force $(docker images | grep dotnet | awk '{print $3}')
