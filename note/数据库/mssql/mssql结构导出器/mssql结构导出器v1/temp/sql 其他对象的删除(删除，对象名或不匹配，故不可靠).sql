--������
select 
(' /* ɾ�� */
 if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].'+ QUOTENAME(#tb.[������])+''') and xtype='''+#tb.xtype+''') 
'+' drop '+(case #tb.xtype when 'TR' then 'Trigger' when 'P' then 'procedure' when 'V' then 'view' else 'function' end)+' [dbo].'+ QUOTENAME(#tb.[������])+'  
') sqlDel
,[�������] sql 
 from #tb   where xtype='TR';