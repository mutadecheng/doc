# shell



## 安装ss服务

```bash
#安装docker
#curl https://raw.githubusercontent.com/serset/doc/master/file/shell/centos7/docker.sh|bash
curl https://serset.github.io/doc/file/shell/centos7/docker.sh|bash

#创建ss容器
docker run -dt --name ss --restart=always -p 2444:6443 saved/ss -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k test123"

```

> 参数解释：  
> -d  后台运行容器，并返回容器ID  
> -t 为容器重新分配一个伪输入终端，通常与 -i 同时使用  
> --name 为容器指定一个名称  
> -p 指定端口映射，格式为：主机(宿主)端口:容器端口  


> 参数解释：  
> -p -s shadowsocks-libev 参数字符串  
> -p ss的运行端口（外部对外端为2444，可修改）  
> -m ss的加密方式  
> -k ss客户端密码  
