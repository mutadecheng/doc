------------------------------------------------------

-- 无法获取 geometry 等类型

exec sp_MShelpcolumns 'SPATIAL_RAILTRANSIT';  

 
---- 

create table #Proc_S_TableStruct_MShelpcolumns([col_name] varchar(200),[col_id] int,[col_typename] varchar(200),[col_len] int,[col_prec] varchar(200),[col_scale] varchar(200),[col_basetypename] varchar(200),[col_defname] varchar(200),[col_rulname] varchar(200),[col_null] int,[col_identity] int,[col_flags] int,[col_seed] int,[col_increment] int,[col_dridefname] varchar(200),[text] text ,[col_iscomputed] varchar(200),[col_text] varchar(200),[col_NotForRepl] int,[col_fulltext] int,[col_AnsiPad] int,[col_DOwner] int,[col_DName] varchar(200),[col_ROwner] int,[col_RName] varchar(200),[collation] varchar(200),[ColType] varchar(200),[column1] int ,[column2] int)

--获取字段基础信息 
insert into #Proc_S_TableStruct_MShelpcolumns  exec sp_MShelpcolumns 'SPATIAL_RAILTRANSIT';  
