SELECT [Name]  FROM sysobjects WHERE [type] = 'U'  and [Name]!='dtproperties'



SELECT
tb.name AS table_name,
col.name AS column_name -- ''as column_type,
colProp.value AS column_comment,
(case when exists(SELECT 1 FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE k where k.TABLE_NAME=tb.name and k.COLUMN_NAME=col.name ) then 1 else 0 end) as primary_key,
col.is_identity AS autoincrement 
FROM sys.tables tb 
INNER JOIN sys.columns col ON col.object_id = tb.object_id 
LEFT JOIN sys.extended_properties colProp ON colProp.major_id = col.object_id AND colProp.minor_id = col.column_id
WHERE tb.name IN ('table1')