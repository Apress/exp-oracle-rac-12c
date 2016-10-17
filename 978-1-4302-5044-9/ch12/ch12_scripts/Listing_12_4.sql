SELECT TO_CHAR(snaps.begin_interval_time, 'DD-MON-YYYY HH24:MI') begin_time,
  snaps.instance_number,
  hist.name,
  TRUNC((hist.bytes_received - lag (hist.bytes_received) OVER (
        PARTITION BY hist.name, startup_time, hist.instance_number
        ORDER BY begin_interval_time, startup_time, 
  hist.instance_number, hist.name))/1048576,2) bytes_rcvd,
  TRUNC((hist.bytes_sent     - lag (hist.bytes_sent) OVER (
        PARTITION BY hist.name, startup_time, hist.instance_number
        ORDER BY begin_interval_time, startup_time, 
          hist.instance_number, hist.name))/1048576,2) bytes_sent
FROM dba_hist_ic_client_stats hist,
  DBA_HIST_SNAPSHOT snaps
WHERE snaps.snap_id           = hist.snap_id
AND snaps.instance_number     = hist.instance_number
AND snaps.begin_interval_time > sysdate-1
AND hist.name                 ='ipq'
ORDER BY snaps.snap_id, instance_number;
