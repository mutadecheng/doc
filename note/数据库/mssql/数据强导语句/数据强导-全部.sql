 
declare @Name varchar(1000);
declare @sql varchar(1000);
 
--(.1)获取所有的用户表
SELECT [Name] into #tb FROM sysobjects WHERE [type] = 'U'  and [Name]!='dtproperties'


--(.2)传递后面各条要插入到的表的表名
select [Name] from #tb
union all select '数据强导-全部数据';

--(.3)返回各个表中的数据
while 1=1
begin
	set @Name=( SELECT top 1  [Name] from #tb)
	if @Name is null 
		break;
	set @sql='select * from  ' + QUOTENAME(@Name)
	exec(@sql)  
	delete  #tb where [Name]=@Name
end
drop table #tb
 
 




 
