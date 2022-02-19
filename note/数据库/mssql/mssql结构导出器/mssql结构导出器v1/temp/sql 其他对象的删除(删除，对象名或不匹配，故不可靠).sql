--触发器
select 
(' /* 删除 */
 if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].'+ QUOTENAME(#tb.[对象名])+''') and xtype='''+#tb.xtype+''') 
'+' drop '+(case #tb.xtype when 'TR' then 'Trigger' when 'P' then 'procedure' when 'V' then 'view' else 'function' end)+' [dbo].'+ QUOTENAME(#tb.[对象名])+'  
') sqlDel
,[声明语句] sql 
 from #tb   where xtype='TR';