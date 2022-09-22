# Usage

```

#把文件夹拷贝到image下
cd /root/image 


#构建镜像
cd coturn
docker build -t serset/coturn -t serset/coturn:1.0 .
 

#推送到镜像仓库
# docker login -u serset -p xxxxxxxxx
docker push serset/coturn
docker push serset/coturn:1.0





```
