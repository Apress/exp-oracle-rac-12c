col event format a30
SELECT inst_id, event, wait_time_milli, wait_count, 
      TRUNC(100*(wait_count/tot),2) per
FROM
  (SELECT inst_id, event, wait_time_milli, wait_count,
    SUM (wait_count) over(partition BY inst_id, event 
                  order by inst_id 
                  rows BETWEEN unbounded preceding AND unbounded following 
                  ) tot
  FROM
    (SELECT * FROM gv$event_histogram
     WHERE event LIKE '%&event_name%'
     ORDER BY inst_id, event#, WAIT_TIME_MILLI
    )
  )
ORDER BY inst_id, event, WAIT_TIME_MILLI 
/
