# Mysql命令行工具


# 一.介绍
 Sqler可以对MySql进行 备份还原、创建数据库、删除数据库。
 以下以docker运行sqler。


# 二.查看帮助  

``` bash
docker run --rm -it serset/sqler dotnet Sqler.dll help

```

``` txt

开始执行命令 help ...
---------------
命令说明：
---------------
help
命令说明：
-c[--command] 要查询的命令。若不指定则返回所有命令的说明。如 help 
示例： help -c help
---------------


```


# 三.备份
备份mysql数据库到指定文件，使用sqler备份方式
> sqler备份步骤为
> 1.构建建库脚本保存到文件（CreateDataBase.sql）
> 2.备份所有表数据到sqlite文件(Data.sqlite3)
> 3.压缩为zip文件

``` bash
#demo:
docker run --rm -it \
-v /root/app/Data:/root/app/Data \
serset/sqler \
dotnet Sqler.dll MySql.BackupSqler \
-ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" \
--filePath "/root/app/Data/Db_Dev.zip"
```

``` txt
MySql.BackupSqler
远程备份数据库。参数说明：备份文件名称和路径指定其一即可,若均不指定则自动生成
-fn[--fileName] (可选)备份文件名称，备份文件在当前管理的备份文件夹中。例如 "DbDev_2020-06-08_135203.zip"
-fp[--filePath] (可选)备份文件路径，例如 "/root/docker/DbDev_2020-06-08_135203.zip"
-c[--useMemoryCache] 若为false则不使用内存进行全量缓存，默认:true。缓存到内存可以加快备份速度。在数据源特别庞大时请禁用此功能（指定false）。
-ConnStr[--ConnectionString] (可选)数据库连接字符串 例如 "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
--DataPath (可选)Data文件夹的路径。可为相对或绝对路径，默认："Data"
示例： MySql.BackupSqler --useMemoryCache false -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" --filePath "/root/docker/DbDev_2020-06-08_135203.zip"

```





# 四.还原
还原mysql备份文件到数据库，使用sqler备份方式

``` bash
#demo:
docker run --rm -it \
-v /root/app/Data:/root/app/Data \
serset/sqler \
dotnet Sqler.dll MySql.Restore \
-ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" \
--filePath "/root/app/Data/Db_Dev.zip"
```

``` txt
MySql.Restore
通过备份文件远程还原数据库。参数说明：备份文件名称和路径指定其一即可
-f[--force] 强制还原数据库。若指定此参数，则在数据库已经存在时仍然还原数据库；否则仅在数据库尚未存在时还原数据库。
-fn[--fileName] (可选)备份文件名称，备份文件在当前管理的备份文件夹中。例如 "DbDev_2020-06-08_135203.bak"
-fp[--filePath] (可选)备份文件路径，例如 "/root/docker/DbDev_2020-06-08_135203.bak"
-ConnStr[--ConnectionString] (可选)数据库连接字符串 例如 "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
--DataPath (可选)Data文件夹的路径。可为相对或绝对路径，默认："Data"
示例： MySql.Restore -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" --filePath "/root/docker/DbDev_2020-06-08_135203.bak"

```



# 五.创建数据库


``` bash
#demo:
docker run --rm -it \
serset/sqler \
dotnet Sqler.dll MySql.CreateDataBase \
-ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
```

``` txt
MySql.CreateDataBase
若数据库不存在，则创建数据库。参数说明：
-ConnStr[--ConnectionString] (可选)数据库连接字符串 例如 "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
--DataPath (可选)Data文件夹的路径。可为相对或绝对路径，默认："Data"
示例： MySql.CreateDataBase -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" 

```





# 六.删除数据库


``` bash
#demo:
docker run --rm -it \
serset/sqler \
dotnet Sqler.dll MySql.DropDataBase \
-ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
```

``` txt
MySql.DropDataBase
若数据库存在，则删除数据库。参数说明：
-ConnStr[--ConnectionString] (可选)数据库连接字符串 例如 "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
--DataPath (可选)Data文件夹的路径。可为相对或绝对路径，默认："Data"
示例： MySql.DropDataBase -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" 

```







