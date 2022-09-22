#复制ssh key
 
chmod 600 /root/docker/git/serset

#推送到github
docker run -it --rm -v /root/docker/git:/root/release serset/git-client bash  
 
ssh-agent bash  
ssh-add /root/release/serset
ssh -T git@github.com -o StrictHostKeyChecking=no
git config --global user.email 'serset@yeah.com'
git config --global user.name 'lith'


mkdir -p /root/code
git clone git@github.com:serset/release.git /root/code

cd /root/code
git lfs migrate import --include-ref=master --include='*.zip' -y
git push -u origin master --force\" "



mkdir -p /root/release/code2

cd /root/release/code

git init

git add a21


# 备注
git commit  -m  'atest'

 git remote rm origin

git remote add origin git@github.com:serset/test.git


git push -u origin master
----------------------
git clone git@github.com:serset/test.git /root/release/code3




#拉取代码
git clone --no-checkout --depth=1 git@github.com:serset/test.git /root/release/code4

#撤销缓存区
git reset HEAD 


# 添加文件

#提交文件到缓存区
git add a.txt1


 
#提交到远程仓库
git commit  -m  'atest'
git push -u origin master







https://www.cnblogs.com/wanqiu/p/4627534.html

https://www.cnblogs.com/hackerkevin/p/4198326.html

https://baijiahao.baidu.com/s?id=1655789896324852747&wfr=spider&for=pc