#构建镜像


#把本文件所在目录下的文件夹拷贝到image
# cd /root/image

#登录
# docker login -u serset -p xxxxxxx

#get version
version=`docker run -i --rm mcr.microsoft.com/dotnet/sdk:7.0 dotnet --info | grep Version | head -n 1`
version=`echo ${version#*:} | sed 's/ //g'`
echo $version

#构建镜像
cd dotnet-debug_7.0
docker build -t serset/dotnet-debug:7.0 -t serset/dotnet-debug:$version -t serset/dotnet:debug-7.0 -t serset/dotnet:debug-$version . 
cd ..

#推送到镜像仓库
docker push serset/dotnet-debug:7.0
docker push serset/dotnet-debug:$version
docker push serset/dotnet:debug-7.0
docker push serset/dotnet:debug-$version





#--------------------------------------------------------------------- 
#删除镜像
# docker rmi --force $(docker images | grep dotnet-debug | awk '{print $3}')


 

#--------------------------------------------------------------------- 
#远程端口 10022
#账号 root/123456



