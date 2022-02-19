-- http://www.maomao365.com/?p=8236

 
  SELECT
SCHEMA_NAME(t.schema_id) AS [�ܹ�����],
t.name AS [���ݱ�����],
i.name AS [��������],
i.type_desc as [��������],
i.is_primary_key as [�Ƿ�����],
i.is_unique as [�Ƿ�Ψһ],
i.is_unique_constraint as [�Ƿ����],
STUFF(REPLACE(REPLACE((
SELECT QUOTENAME(c.name) + CASE WHEN ic.is_descending_key = 1 THEN ' DESC' ELSE '' END AS [data()] 
FROM sys.index_columns AS ic
INNER JOIN sys.columns AS c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE ic.object_id = i.object_id AND ic.index_id = i.index_id AND ic.is_included_column = 0
ORDER BY ic.key_ordinal
FOR XML PATH
), '<row>', ', '), '</row>', ''), 1, 2, '') AS [�������б�],
STUFF(REPLACE(REPLACE((
SELECT QUOTENAME(c.name) AS [data()]
FROM sys.index_columns AS ic
INNER JOIN sys.columns AS c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE ic.object_id = i.object_id AND ic.index_id = i.index_id AND ic.is_included_column = 1
ORDER BY ic.index_column_id
FOR XML PATH
), '<row>', ', '), '</row>', ''), 1, 2, '') AS [��������Ϣ],
u.user_seeks,
u.user_scans,
u.user_lookups,
u.user_updates
into #Proc_S_TableStruct_Index
FROM sys.tables AS t
INNER JOIN sys.indexes AS i ON t.object_id = i.object_id
LEFT JOIN sys.dm_db_index_usage_stats AS u ON i.object_id = u.object_id AND i.index_id = u.index_id

WHERE t.is_ms_shipped = 0
AND i.type <> 0;


select * from #Proc_S_TableStruct_Index where [��������]='NONCLUSTERED' --and [���ݱ�����]='Tileset_File'

drop table #Proc_S_TableStruct_Index;

/*
CREATE NONCLUSTERED INDEX IX_Tileset_File ON dbo.Tileset_File
	(
	professionalTreeId,
	creator DESC,
	floorId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


*/

