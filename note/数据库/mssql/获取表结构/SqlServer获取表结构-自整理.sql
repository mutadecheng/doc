 declare @tbName varchar(100); 
 set @tbName='SPATIAL_RAILTRANSIT'

 
SELECT 
  C.column_id  [col_id],
  C.[name] [col_name],
  T.[name] col_typename, 
 
  --C.max_length col_len,
  COLUMNPROPERTY(C.[object_id],C.[name],'PRECISION')   col_len,
 
  C.[precision] col_prec,
 
  --C.scale col_scale,
  COLUMNPROPERTY(C.[object_id],C.[name],'Scale')  col_scale,
 
  C.is_identity col_identity,
   --COLUMNPROPERTY(C.[object_id],C.[name],'IsIdentity')  col_identity,
 
  IDENT_SEED (@tbName)  col_seed,
  IDENT_INCR (@tbName)  col_increment,
  C.collation_name collation,
  C.is_nullable col_null,
  D.[definition] as col_DefaultValue,
  D.[name] [ConstraintName_DefaultValue]  

FROM sys.columns C
INNER JOIN sys.types T ON C.user_type_id=T.user_type_id
LEFT JOIN sys.default_constraints D ON C.[object_id]=D.parent_object_id AND C.column_id=D.parent_column_id AND C.default_object_id=D.[object_id]  
WHERE C.[object_id]=(select top 1 [object_id] from  sys.objects    where [name]=@tbName and [type]='U' AND [is_ms_shipped]=0)
ORDER BY  C.column_id
 

 