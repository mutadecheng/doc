# docker部署
> 参考 https://github.com/itzg/docker-minecraft-server/blob/master/README.md
> https://minecraft.fandom.com/zh/wiki/教程/架设服务器
> https://www.jianshu.com/p/bfdbbdd48dbf		MC服务器快速搭建&MOD推荐&性能优化
> http://www.nasyun.com/thread-68826-1-1.html		docker搭建minecraft私有服务器




# 创建容器

docker run -d --restart=always \
--name minecraft \
-p 6192:25565 \
-v /etc/localtime:/etc/localtime \
-v /root/docker/minecraft/data:/data \
-e INIT_MEMORY=300M -e MAX_MEMORY=1000M \
-e VERSION=1.17.1 -e EULA=TRUE \
itzg/minecraft-server 


docker run -d --name minecraft-rcon \
-p 4326:4326 -p 4327:4327 \
--link minecraft \
-e RWA_PASSWORD=asdgseedddasdg \
-e RWA_RCON_HOST=minecraft -e RWA_RCON_PORT=25575 -e RWA_RCON_PASSWORD=minecraft \
itzg/rcon




# mc登录
  minecraft.sers.cloud:6192

# mc管理
  http://minecraft.sers.cloud:4326
  admin/asdgseedddasdg
 

#---------------------

docker rm minecraft -f
docker rm -f minecraft-rcon


docker logs minecraft
docker logs minecraft-rcon

docker restart minecraft



#------------------------------------
# 解决问题 登录失败:null

让服务器的管理员在服务端关闭正版验证(在server.propeties将online-mode=true修改为online-mode=false后重启服务器)


#------------------------------------
# 启用rcon

# 修改server.propeties文件（默认无需修改）
enable-rcon=true
rcon.port=25575
rcon.password=minecraft

minecraft.sers.cloud:25575 minecraft






--------------------------------------------------------------------------------
#导出镜像
docker save -o /root/docker/minecraft/minecraft-server.tar itzg/minecraft-server 
docker save -o /root/docker/minecraft/rcon.tar itzg/rcon

#导入镜像
docker load -i /root/docker/minecraft/minecraft-server.tar
docker load -i /root/docker/minecraft/rcon.tar
