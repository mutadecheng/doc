set -e

#----------------------------------------------
#(x.1)参数
args_="

export SVN_SERVER=svn.com
export SVN_USER=github
export SVN_PASSWORD=xxxxxxxxxx

export GIT_SSH_SECRET=xxxxxx

rm -rf /root/temp
mkdir /root/temp
cd /root/temp
# "

SVN_URL=svn://${SVN_SERVER}/2020LithProject/FileZip/FileZip
GIT_URL=git@github.com:serset/FileZip.git


basePath=$PWD
echo basePath: $basePath

echo start commit
#----------------------------------------------
#(x.3)从svn拉取code
docker run -i --rm -v $basePath/svn:/root/svn serset/svn-client svn checkout "$SVN_URL" /root/svn --username "$SVN_USER" --password "$SVN_PASSWORD" --no-auth-cache

#(x.4)get version
version=""
version=`grep '<Version>' $basePath/svn -r --include *.csproj | grep -oP '>(.*)<' | tr -d '<>'`
echo version: $version

#----------------------------------------------
#(x.5)github-clone and push

#复制ssh key
echo "${GIT_SSH_SECRET}" > $basePath/serset
chmod 600 $basePath/serset

docker run -i --rm -v $basePath:/root/code serset/git-client bash -c "
set -e

#初始化账户
ssh-agent bash -c \"
ssh-add /root/code/serset
ssh -T git@github.com -o StrictHostKeyChecking=no
git config --global user.email 'serset@yeah.com'
git config --global user.name 'lith'

#从github拉取代码
mkdir -p /root/code/git
git clone '${GIT_URL}' /root/code/git

#构建git临时文件夹
cp -rf /root/code/svn /root/code/git-t
rm -rf /root/code/git-t/.svn
cp -r /root/code/git/.git /root/code/git-t/


#提交到github
cd /root/code/git-t
git add .  -A
git commit -m  'auto commit ${version}'
git push -u origin

#提交tag
git tag ${version} -m  'auto commit ${version}'
git push origin --tags

\" " 

echo commit succeed!


#(x.6)删除临时文件夹
rm -rf  ${basePath}
 