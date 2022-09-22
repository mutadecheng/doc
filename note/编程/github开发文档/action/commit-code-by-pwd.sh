# set -e

# bash 99.github-commit.sh



svnServer=svn://svn.sers.cloud/2020LithProject/Library/Vit.Ioc
svnUser=lith
svnPwd=xxxxx

gitServer=https://serset:password@github.com/serset/Vit.Ioc



basePath=/root/docker/jenkins/workspace/temp

codePath=${basePath}/svn


#(x.2)清空文件夹
rm -rf  ${basePath}
mkdir -p ${basePath}



#(x.3)从svn拉取code
docker run -i --rm -v $basePath/svn:/root/svn serset/svn-client svn checkout "$svnServer" /root/svn --username "$svnUser" --password "$svnPwd" --no-auth-cache


#(x.4)get version
version=""
version=`grep '<Version>' ${codePath} -r --include *.csproj | grep -oP '>(.*)<' | tr -d '<>'`



#(x.5)github-clone and push
docker run -i --rm -v $basePath:/root/code serset/git-client bash -c "
set -ex

rm -rf /root/code/git
rm -rf /root/code/git-t
mkdir -p /root/code/git

git clone '${gitServer}' /root/code/git
	
#构建临时文件夹
cp -r /root/code/svn /root/code/git-t
rm -rf /root/code/git-t/.svn
cp -r /root/code/git/.git /root/code/git-t/

git config --global user.email 'serset@yeah.com'
git config --global user.name lith

cd /root/code/git-t

#添加文件
git add .  -A

#添加备注
git commit -m  'auto commit ${version}'

#提交到服务器
git push -u origin

#创建tag
git tag ${version} -m  'auto commit ${version}'

#推送tag
git push origin --tags

"





#(x.6)删除临时文件夹
rm -rf  ${basePath}

 