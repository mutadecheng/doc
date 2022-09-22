# Linux生成https证书
> https://www.cnblogs.com/php-no-2/p/11276323.html


#------------------------
# 创建crt证书

dn=robotcar.ki.lith.cloud
#1.生成秘钥文件 server.key
> 输入两次密码(按回车使用空密码)
openssl genrsa -des3 -out $dn.server.key 2048
>以后使用此文件(通过openssl提供的命令或API)可能经常回要求输入密码,可通过以下命令去除密码
openssl rsa -in $dn.server.key -out $dn.server.key

#2.创建服务器证书的申请文件 server.csr
> Country Name填CN,Common Name填域名也可以不填（不填浏览器会认为不安全）
openssl req -new -key $dn.server.key -out $dn.server.csr


#3.创建CA证书(有效期十年) ca.crt
openssl req -new -x509 -key $dn.server.key -out $dn.ca.crt -days 3650
> 此时,你可以得到一个ca.crt的证书,这个证书用来给自己的证书签名. 

#4.创建服务器证书(有效期十年) server.crt
openssl x509 -req -days 3650 -in $dn.server.csr -CA $dn.ca.crt -CAkey $dn.server.key -CAcreateserial -out $dn.server.crt



#一共生成了5个文件,server.key和server.crt是nginx需要的证书文件
server.key	server.csr	ca.crt		server.crt ca.srl       




#合成.pfx证书
openssl pkcs12 -export -inkey $dn.server.key -in $dn.server.crt -out $dn.server.pfx 




#------------------------
# 创建pfx证书
dn=robotcar.ki.lith.cloud

# 生成私钥
#工具程序 命令 模式 密码 输出文档
openssl genrsa -aes256 -passout "pass:lith" -out $dn.pem 4096

# 生成公钥
#工具程序 命令 生成新证书 自签名证书  有效期限   私钥 密码 输出文件 组织信息
openssl req -new -x509 -days 3650 -key $dn.pem -passin "pass:lith" -out $dn.server.csr -subj "/C=CN"

# 打包为pfx
#工具程序 命令 模式 公钥 私钥 输出
openssl pkcs12 -export -in $dn.server.csr -inkey $dn.pem -passin "pass:lith" -out $dn.pfx








