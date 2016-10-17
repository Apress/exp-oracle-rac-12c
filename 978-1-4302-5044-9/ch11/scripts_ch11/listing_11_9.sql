REM Derive a resource_name string from object_id 
col res  new_value resource_name

SELECT DISTINCT '[0x'
    ||trim(TO_CHAR(object_id, 'xxxxxxxx'))
    ||'][0x'
    || trim(TO_CHAR(0,'xxxx'))
    || '],[SV]' res
FROM dba_objects WHERE object_name=upper('&objname')
AND owner=upper('&owner') AND object_type LIKE 'SEQUENCE%'
/
REM Using the derived resource_name, identify all GES resources
col master_node head 'Mast|node' format 99
vol value_blk format a30
 SELECT inst_id, resource_name, master_node, value_blk
FROM gv$ges_resource WHERE resource_name LIKE '&resource_name%'
/

REM Identify all GES locks for that resource

col state format a10
col inst_id format 99 head Inst
col owner_node format 99 head 'Owner|Node'

SELECT inst_id, resource_name1, pid, state,
  	    owner_node , grant_level, request_level
FROM gv$ges_enqueue
WHERE resource_name1 LIKE '&resource_name%'
/
