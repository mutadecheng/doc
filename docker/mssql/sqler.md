 


#强制还原数据库
docker run --rm -it \
-v /root/data:/data  \
serset/sqler \
dotnet Sqler.dll SqlServer.RestoreLocalBak -f \
-f \
--filePath "/data/db.bak" \
--ConnectionString 'Data Source=192.168.3.221,1434;Database=SHMetro;UID=sa;PWD=LongLongPassword1!;' \
--databasePath "/data"


#创建数据库
docker run --rm -it serset/sqler \
dotnet Sqler.dll SqlServer.CreateDataBase \
--ConnectionString 'Data Source=192.168.3.221,1434;Database=SHMetro;UID=sa;PWD=LongLongPassword1!;' \
--databasePath "/data"



#删除数据库
docker run --rm -it serset/sqler \
dotnet Sqler.dll SqlServer.DropDataBase \
--ConnectionString 'Data Source=192.168.3.221,1434;Database=SHMetro;UID=sa;PWD=LongLongPassword1!;'




---------------------------------
 

## 二.备份数据库
备份数据库到指定文件，使用sqler备份方式
> sqler备份步骤为：    
> 1.构建建库脚本保存到文件(CreateDataBase.sql)    
> 2.备份所有表数据到sqlite文件(Data.sqlite3)    
> 3.压缩为zip文件    

demo：
``` bash
docker run --rm -it \
-v /root/data:/root/data  \
serset/sqler  \
dotnet Sqler.dll SqlServer.BackupLocalBak \
--filePath "/root/data/wordpress.sqler.zip" \
--ConnectionString "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
```

参数说明：
``` txt
SqlServer.BackupLocalBak
本地bak备份数据库。参数说明：备份文件名称和路径指定其一即可,若均不指定则自动生成
-fn[--fileName] (可选)备份文件名称，备份文件在当前管理的备份文件夹中。例如 "DbDev_2020-06-08_135203.bak"
-fp[--filePath] (可选)备份文件路径，例如 "/root/docker/DbDev_2020-06-08_135203.bak"
-ConnStr[--ConnectionString] (可选)数据库连接字符串 例如 "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
--DataPath (可选)Data文件夹的路径。可为相对或绝对路径，默认："Data"
示例： SqlServer.BackupLocalBak -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" --filePath "/root/docker/DbDev_2020-06-08_135203.bak"
```


## 三.还原数据库
还原备份文件到数据库

demo：
``` bash
#强制还原数据库
docker run --rm -it \
-v /root/data:/bak  \
serset/sqler  \
dotnet Sqler.dll SqlServer.Restore -f \
--filePath "/bak/wordpress.sqler.zip" \
--databasePath "/data" \
--ConnectionString "Data Source=192.168.1.45,1433;Database=Db_Dev;UID=sa;PWD=123456;"
```

参数说明：
``` txt
SqlServer.Restore
通过备份文件远程还原数据库。参数说明：备份文件名称和路径指定其一即可
-f[--force] 强制还原数据库。若指定此参数，则在数据库已经存在时仍然还原数据库；否则仅在数据库尚未存在时还原数据库。
-fn[--fileName] (可选)备份文件名称，备份文件在当前管理的备份文件夹中。例如 "DbDev_2020-06-08_135203.bak"
-fp[--filePath] (可选)备份文件路径，例如 "/root/docker/DbDev_2020-06-08_135203.bak"
-ConnStr[--ConnectionString] (可选)数据库连接字符串 例如 "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
-dp[--databasePath] (可选)数据库文件存放的路径 例如 "/data/mssql"
--DataPath (可选)Data文件夹的路径。可为相对或绝对路径，默认："Data"
示例： SqlServer.Restore -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" --filePath "/root/docker/DbDev_2020-06-08_135203.bak"

```



# 四.创建数据库

demo：
``` bash
docker run --rm -it \
serset/sqler \
dotnet Sqler.dll SqlServer.CreateDataBase \
--ConnectionString 'Data Source=192.168.3.221,1434;Database=Db_Dev2;UID=sa;PWD=LongLongPassword1!;' \
--databasePath "/data"
```

参数说明：
``` txt
SqlServer.CreateDataBase
若数据库不存在，则创建数据库。参数说明：
-ConnStr[--ConnectionString] (可选)数据库连接字符串 例如 "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
-dp[--databasePath] (可选)数据库文件存放的路径 例如 "/data/mssql"
--DataPath (可选)Data文件夹的路径。可为相对或绝对路径，默认："Data"
示例： SqlServer.CreateDataBase -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
```

 