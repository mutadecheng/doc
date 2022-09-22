
#-------------------------------------
#ha强制删除实体

在ha的state restore（config/.storage/core.restore_state）文件中，找到相应的entity id，删除，重启ha。




#-------------------------------------
#ha允许nginx代理访问


#(1)查看nginx网络ip
docker network inspect InnerNet 
> "IPv4Address": "172.21.0.10/16",


#(2)修改文件 docker/HomeAssistant/config/configuration.yaml，添加如下内容
http:
  use_x_forwarded_for: True
  trusted_proxies:
    - 172.21.0.10

#(3)重启HA即可通过nginx代理访问
