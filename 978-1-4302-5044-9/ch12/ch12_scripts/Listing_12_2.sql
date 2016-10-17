col username for a12
col "QC SID" for A6
col SID for A6
col "QC/Slave" for A10
col "Requested DOP" for 9999
col "Actual DOP" for 9999
col server_set for  A10
set pages 100
select
  decode(px.qcinst_id,NULL,username,
        ' - '||lower(substr(s.program,length(s.program)-4,4) ) ) "Username",
  decode(px.qcinst_id,NULL, 'QC', '(Slave)') "QC/Slave" ,
  to_char( px.server_set) server_set,
  to_char(s.sid) "SID",
  decode(px.qcinst_id, NULL ,to_char(s.sid) ,px.qcsid) "QC SID",
  px.req_degree "Requested DOP",
  px.degree "Actual DOP"
from
  v$px_session px,
  v$session s
where
  px.sid=s.sid (+)
 and
  px.serial#=s.serial#
order by 5 , 1 desc
/
