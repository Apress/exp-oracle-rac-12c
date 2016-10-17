select 
    to_date(to_char(trunc(begin_interval_time), 'DD-MON-YYYY'), 'DD-MON-YYYY') DAY, 
    instance_number,
    trunc(max(bytes/1024/1024),2)  sz_MB
  from 
   (select begin_interval_time, s.instance_number, sum(bytes) bytes
    from 
      dba_hist_sgastat g, dba_hist_snapshot s
   where (name like '%ges%' or name like '%gcs%')
    and trunc(begin_interval_time) >= sysdate -30
    and s.snap_id = g.snap_id
    and s.instance_number = g.instance_number
    group by begin_interval_time, s.instance_number
   )
  group by 
    to_date(to_char(trunc(begin_interval_time), 'DD-MON-YYYY'), 'DD-MON-YYYY'), 
    instance_number
order by 1
/
