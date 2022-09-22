# docker部署
> 参考 https://github.com/LomotHo/minecraft-bedrock/blob/master/readme_zh.md
 

# 创建容器
> --name 容器名称，可自定义  
> --restart=always 自动重启  
> -v /etc/localtime:/etc/localtime 挂载宿主机localtime文件解决容器时间与主机时区不一致的问题  
> -v $PWD/data:/data 将主机中当前目录下的data挂载到容器的/data  
> --net=host 网络直接使用宿主机网络  
> -p 6022:6022 端口映射  


docker rm mc -f

 
docker run -d --restart=always \
--name mc \
-p 6192:19132 \
-v /etc/localtime:/etc/localtime \
-v /root/docker/minecraft-bedrock/data:/data \
-e INIT_MEMORY=300M -e MAX_MEMORY=3000M \
lomot/minecraft-bedrock:1.17.10.04
 
 
docker logs mc



be.sers.cloud:6192

 





注意移动全部数据
1.world文件夹   里面保存了地图和玩家资料
2.plugin文件夹   里面保存了插件信息和一部分玩家信息
3.mods文件夹   如果有的话（纯净服可以忽略）
4.注意一下server.properties中的端口号






#---------------------
# 登录失败:null

让服务器的管理员在服务端关闭正版验证(在server.propeties将online-mode=true修改为online-mode=false后重启服务器)

 
 
