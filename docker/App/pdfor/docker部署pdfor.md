# docker部署pdfor
> Pdfor为一款跨平台的pdf转换器。  
> 可以把doc、docx、xls、xlsx、ppt、pptx 、html、txt 等文件转换为pdf格式。  
> 通过http api方式对外提供服务,接口地址为 /Pdfor/ConvertToPdf。  
> 运行环境为net core 2.1。  


# 1.创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  

``` bash
# 创建容器
docker run --name=pdfor --restart=always -d -p 4301:4301 serset/pdfor

# 部署成功后访问 http://ip:4301

```


# 2.文件转换
``` bash

# 查看帮助
docker run -it --rm serset/pdfor libreoffice --help

#转换docx为pdf
docker run -it --rm -v /root/temp:/root/temp serset/pdfor \
libreoffice --headless  --convert-to pdf --outdir "/root/temp/" "/root/temp/a.docx"



```



# 4.容器常用命令
``` bash
#查看容器logs
docker logs pdfor

#停止容器
docker stop pdfor

#打开容器
docker start pdfor

#重启容器
docker restart pdfor

#删除容器
docker rm pdfor -f

#进入容器执行命令
docker exec -it pdfor bash
```

