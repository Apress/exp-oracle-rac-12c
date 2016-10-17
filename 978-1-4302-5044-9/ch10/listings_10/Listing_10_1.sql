DROP TABLE t_one;
CREATE TABLE t_one (n1 NUMBER , v1 VARCHAR2(100));
INSERT INTO t_one
SELECT n1, lpad (n1, 100,'DEADBEEF')
FROM
  ( SELECT level n1 FROM dual CONNECT BY level <=500
  );
COMMIT;
CREATE INDEX t_one_n1 ON t_one (n1);
EXEC dbms_stats.gather_table_stats ( USER, 't_one', CASCADE =>true);

SELECT n1,
  dbms_rowid.rowid_to_absolute_fno (rowid, 'RS','T_ONE') fno,
  dbms_rowid.rowid_block_number(rowid) block,
  dbms_rowid.rowid_object(rowid) obj,
  LENGTH(v1) v1
FROM t_one
WHERE n1=100;

col res  new_value resource_name

SELECT DISTINCT '[0x'||trim(TO_CHAR(dbms_rowid.rowid_block_number(rowid), 'xxxxxxxx'))
  ||'][0x'|| trim(TO_CHAR(dbms_rowid.rowid_to_absolute_fno (rowid,user,'T_ONE'),'xxxx'))
  || '],[BL]' res
FROM t_one
WHERE n1=100;

SELECT resource_name, ON_CONVERT_Q, ON_GRANT_Q, MASTER_NODE
FROM gv$ges_resource
WHERE resource_name LIKE '&resource_name%'
/
col state format a15
SELECT resource_name1, grant_level, state, owner_node
FROM v$ges_enqueue
WHERE resource_name1 LIKE '&resource_name%'
/
