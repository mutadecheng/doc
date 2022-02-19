


--存放要导出的数据的DataCode(包含此节点，任意两个DataCode之间不可存在祖先关系)
select 'Task' as Datacode     into #PDC
union all select 'Tool'   

select -1 as  [ID],convert(varchar(1000),null) as PDataCode  into #tree  

declare @Datacode varchar(1000);declare @ID  int;

while 1=1
begin
	set @Datacode=(select top 1 Datacode from #PDC)
	if(@Datacode is  null) break;
	delete #PDC where DataCode=@Datacode;
	set @ID=(select top 1 [ID] from T_TreeData where DataCode=@Datacode)
	if( @ID is  null)
	begin
		set  @Datacode=@Datacode+'在TreeData中不存在';
		RAISERROR ( @Datacode, 16,1 );	
	end
	insert into #tree([ID])  
	exec Proc_S_Tree_SelectCascade 'T_TreeData',@ID,null
	update #tree set PDataCode=(select top 1 [DataCode] from T_TreeData p where p.[ID]=(select top 1 c.[PID] from T_TreeData c where c.[ID]=@ID) )
	where [ID]=@ID;
end

select  T_TreeData.*,#tree.[PDataCode]  from T_TreeData,#tree where T_TreeData.[ID]=#tree.[ID] order by T_TreeData.[ID] 

drop table #PDC;
drop table #tree