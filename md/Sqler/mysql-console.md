# Mysql�����й���


# һ.����
 Sqler���Զ�MySql���� ���ݻ�ԭ���������ݿ⡢ɾ�����ݿ⡣
 ������docker����sqler��


# ��.�鿴����  

``` bash
docker run --rm -it serset/sqler dotnet Sqler.dll help

```

``` txt

��ʼִ������ help ...
---------------
����˵����
---------------
help
����˵����
-c[--command] Ҫ��ѯ���������ָ���򷵻����������˵������ help 
ʾ���� help -c help
---------------


```


# ��.����
����mysql���ݿ⵽ָ���ļ���ʹ��sqler���ݷ�ʽ
> sqler���ݲ���Ϊ
> 1.��������ű����浽�ļ���CreateDataBase.sql��
> 2.�������б����ݵ�sqlite�ļ�(Data.sqlite3)
> 3.ѹ��Ϊzip�ļ�

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
Զ�̱������ݿ⡣����˵���������ļ����ƺ�·��ָ����һ����,������ָ�����Զ�����
-fn[--fileName] (��ѡ)�����ļ����ƣ������ļ��ڵ�ǰ����ı����ļ����С����� "DbDev_2020-06-08_135203.zip"
-fp[--filePath] (��ѡ)�����ļ�·�������� "/root/docker/DbDev_2020-06-08_135203.zip"
-c[--useMemoryCache] ��Ϊfalse��ʹ���ڴ����ȫ�����棬Ĭ��:true�����浽�ڴ���Լӿ챸���ٶȡ�������Դ�ر��Ӵ�ʱ����ô˹��ܣ�ָ��false����
-ConnStr[--ConnectionString] (��ѡ)���ݿ������ַ��� ���� "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
--DataPath (��ѡ)Data�ļ��е�·������Ϊ��Ի����·����Ĭ�ϣ�"Data"
ʾ���� MySql.BackupSqler --useMemoryCache false -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" --filePath "/root/docker/DbDev_2020-06-08_135203.zip"

```





# ��.��ԭ
��ԭmysql�����ļ������ݿ⣬ʹ��sqler���ݷ�ʽ

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
ͨ�������ļ�Զ�̻�ԭ���ݿ⡣����˵���������ļ����ƺ�·��ָ����һ����
-f[--force] ǿ�ƻ�ԭ���ݿ⡣��ָ���˲������������ݿ��Ѿ�����ʱ��Ȼ��ԭ���ݿ⣻����������ݿ���δ����ʱ��ԭ���ݿ⡣
-fn[--fileName] (��ѡ)�����ļ����ƣ������ļ��ڵ�ǰ����ı����ļ����С����� "DbDev_2020-06-08_135203.bak"
-fp[--filePath] (��ѡ)�����ļ�·�������� "/root/docker/DbDev_2020-06-08_135203.bak"
-ConnStr[--ConnectionString] (��ѡ)���ݿ������ַ��� ���� "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
--DataPath (��ѡ)Data�ļ��е�·������Ϊ��Ի����·����Ĭ�ϣ�"Data"
ʾ���� MySql.Restore -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" --filePath "/root/docker/DbDev_2020-06-08_135203.bak"

```



# ��.�������ݿ�


``` bash
#demo:
docker run --rm -it \
serset/sqler \
dotnet Sqler.dll MySql.CreateDataBase \
-ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
```

``` txt
MySql.CreateDataBase
�����ݿⲻ���ڣ��򴴽����ݿ⡣����˵����
-ConnStr[--ConnectionString] (��ѡ)���ݿ������ַ��� ���� "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
--DataPath (��ѡ)Data�ļ��е�·������Ϊ��Ի����·����Ĭ�ϣ�"Data"
ʾ���� MySql.CreateDataBase -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" 

```





# ��.ɾ�����ݿ�


``` bash
#demo:
docker run --rm -it \
serset/sqler \
dotnet Sqler.dll MySql.DropDataBase \
-ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
```

``` txt
MySql.DropDataBase
�����ݿ���ڣ���ɾ�����ݿ⡣����˵����
-ConnStr[--ConnectionString] (��ѡ)���ݿ������ַ��� ���� "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;"
--DataPath (��ѡ)Data�ļ��е�·������Ϊ��Ի����·����Ĭ�ϣ�"Data"
ʾ���� MySql.DropDataBase -ConnStr "Data Source=.;Database=Db_Dev;UID=sa;PWD=123456;" 

```







