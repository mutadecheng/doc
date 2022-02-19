 
------------
git config --global user.email "serset@yeah.com"
git config --global user.name "lith"

#克隆branch 2.1.1/release 到本地
git clone -b 2.1.1/release https://github.com/serset/Sers.git /root/git


#更新代码到本地
cd /root/git
git pull

#---------------------------------------------------------------------
cd /root/git/Vit.AspNetCore.BackgroundTask

#初始化
git init

#添加所有变更的文件
git add .  -A

#添加备注
git commit -m "2.1.1"


#推送代码到服务器
git push -u origin




#创建tag
git tag <tag名>

#推送tag
git push origin <tag名>

#推送所有tag
git push origin --tags

#------------------------------------------
#创建分支(-M 同时设为主分支)
git branch 1.3 -M

#切换到新分支
git checkout 1.3


#提交到服务器  （分支为1.3）
git push -u origin 1.3


 

------------------------------------------
# Git 配置 SSH keys


#按需创建docker临时容器
docker run -it --rm -v /root/git:/root/git serset/git-client bash



#(x.1)生成并登记ssh Key
#生成SSH指纹
# ssh-keygen -t rsa -b 4096 -C "serset@yeah.com" -f /root/git/serset
 
#将公钥告诉 GitHub
#登录GitHub，New SSH key，Key的值为上述 id_rsa.pub 文件中的内容



#(x.2)客户端启用ssh Key

#如果执行ssh-add时提示”Could not open a connection to your authentication agent”，执行命令
ssh-agent bash

#将私钥id_rsa添加到ssh代理
ssh-add /root/git/serset

#确认是否加入成功
# ssh-add -l

#测试是否可以登录
ssh -T git@github.com -o StrictHostKeyChecking=no




#(x.3)git上传单个文件

git config --global user.email 'serset@yeah.com'
git config --global user.name 'lith'

mkdir -p /root/git/code
cd /root/git/code

git clone git@github.com:serset/release.git /root/git/code



mkdir -p /root/git/code/sqler2
echo "hello world2!" > sqler2/a2.zip


git add sqler2/a2.zip

# 备注
git commit  -m  'auto commit'
 
#推送
git push -u origin master
 





# git clone 忽略大文件
> https://www.thinbug.com/q/33104475