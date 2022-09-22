# SVN跨版本库迁移目录并保留提交日志
> https://www.cnblogs.com/mao2080/p/7731849.html 



docker exec -it svn /bin/sh


#导出源仓库
svnadmin dump /var/opt/svn/2020LithProject/ > /var/opt/svn/2020LithProject.dump

#过滤非目标文件夹（svndumpfilter include表示只保留指定目录和文件）(若不想重编版本号，去除参数--drop-all-empty-revs --renumber-revs)
svndumpfilter --drop-all-empty-revs --renumber-revs include MicroControl < /var/opt/svn/2020LithProject.dump > /var/opt/svn/MicroControl.dump

#还原至目标仓库
svnadmin load /var/opt/svn/2022LithProject/MicroControl < /var/opt/svn/MicroControl.dump

