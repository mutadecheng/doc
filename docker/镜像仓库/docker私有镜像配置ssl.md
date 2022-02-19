
#(x.1)[服务端]创建证书(Common Name 对应域名  如 *.docker.io)
mkdir -p /root/docker/registry/ssl
openssl req -newkey rsa:4096 -nodes -sha256 -keyout /root/docker/registry/ssl/registry-1.docker.io.key -x509 -days 36500 -out /root/docker/registry/ssl/registry-1.docker.io.crt


#(x.2)[服务端]创建容器并运行
#docker run -d --restart=always -v /root/docker/registry/data:/var/lib/registry -p 80:5000 --name registry registry:2.7.1
docker run -d --restart=always --name registry -v /root/docker/registry/data:/var/lib/registry -v /root/docker/registry/ssl:/certs -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry-1.docker.io.crt -e REGISTRY_HTTP_TLS_KEY=/certs/registry-1.docker.io.key -p 443:443 registry:2.7.1




#(x.3)[客户端]解决问题 x509: certificate signed by unknown authority
复制文件registry-1.docker.io.crt到/etc/ssl/certs/

 
 