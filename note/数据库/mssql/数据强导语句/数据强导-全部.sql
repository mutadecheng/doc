 
declare @Name varchar(1000);
declare @sql varchar(1000);
 
--(.1)��ȡ���е��û���
SELECT [Name] into #tb FROM sysobjects WHERE [type] = 'U'  and [Name]!='dtproperties'


--(.2)���ݺ������Ҫ���뵽�ı�ı���
select [Name] from #tb
union all select '����ǿ��-ȫ������';

--(.3)���ظ������е�����
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
 
 




 
