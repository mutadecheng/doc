#构建镜像


#把本文件所在目录下的文件夹拷贝到image
# cd /root/image

#登录
# docker login -u serset -p xxxxxxx



#构建镜像
cd dotnet-debug_6.0
docker build -t serset/dotnet-debug:6.0 . 
cd ..

#推送到镜像仓库
docker push serset/dotnet-debug:6.0
 



#--------------------------------------------------------------------- 
#删除镜像
# docker rmi --force $(docker images | grep dotnet-debug | awk '{print $3}')


 

#--------------------------------------------------------------------- 
#远程端口 10022
#账号 root/123456



