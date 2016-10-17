col state format A10
col pid format 99999999
begin
 backup.print_Table ('
with dl as (
SELECT inst_id, resource_name1, grant_level, request_level,
  transaction_id0, which_queue, state, pid, blocked ,
  blocker
FROM gv$ges_blocking_enqueue
WHERE transaction_id0!=0 )
SELECT dl.inst_id, dl.resource_name1, dl.grant_level,
  dl.request_level, dl.state, s.sid, sw.event,
  sw.seconds_in_wait sec
FROM dl,
  gv$process p, gv$session s, gv$session_wait sw
WHERE (dl.inst_id = p.inst_id AND dl.pid        = p.spid)
AND (p.inst_id    = s.inst_id AND p.addr        = s.paddr)
AND (s.inst_id    = sw.inst_id AND s.sid        = sw.sid)
ORDER BY sw.seconds_in_wait DESC
');
end;
/

