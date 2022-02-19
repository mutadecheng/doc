https://zzz.buzz/zh/2016/04/19/the-guide-to-git-lfs/ Git LFS 操作指南
https://www.jianshu.com/p/22e9eb221fd4?utm_content=note&utm_medium=seo_notes github大文件提交以及LFS的简单使用
https://murphypei.github.io/blog/2019/12/git-lfs Git-LFS 使用和迁移


#(x.1)安装
apt-get update

apt-get install curl -y

curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

apt-get install git-lfs



#(x.2)对仓库开启lfs

#拉取仓库
git clone git@github.com:serset/release_demo.git --depth=1 /root/release/code

#开启lfs
git lfs install

#指定zip文件为大文件
git lfs track "*.zip"
#推送配置到仓库
git add .gitattributes
git commit -m "add .gitattributes"
git push -u origin master 



#(x.3)提交文件（会自动按配置追踪大文件）
git add .
git commit -m 'auto commit'
git push -u origin master




#(x.4)升级master 分支，将历史提交中的 *.zip 都用 git lfs 进行管理
git lfs migrate import --include-ref=master --include="*.zip" -y
#强制提交
git push -u origin master --force




#(x.5)重新拉取仓库（不拉取大文件,可不指定--depth=1 ）
mkdir -p /root/release/code
GIT_LFS_SKIP_SMUDGE=1 git clone git@github.com:serset/release_demo.git --depth=1 /root/release/code

