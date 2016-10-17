set lines 160
col begin_interval_time format a30
col event_name format a30
col instance_number format 99 head "Inst"
break on begin_interval_time
SELECT snaps.begin_interval_time,
  snaps.instance_number,
  hist.event_name,
  hist.wait_time_milli,
  hist.wait_count
FROM dba_hist_event_histogram hist, DBA_HIST_SNAPSHOT snaps
WHERE snaps.snap_id           = hist.snap_id
AND snaps.instance_number     = hist.instance_number
AND snaps.begin_interval_time > sysdate-1
AND hist.event_name           = lower('&event_name')
ORDER BY snaps.snap_id ,
  instance_number,
  wait_time_milli 
/
