WITH ash_gc AS
  (SELECT    /*+ materialize */ inst_id, event, sql_id, COUNT(*) cnt
  FROM gv$active_session_history
  WHERE event=lower('&event')
  GROUP BY inst_id, event, sql_id
  HAVING COUNT (*) > &threshold )
SELECT inst_id, sql_id, cnt FROM ash_gc
ORDER BY cnt DESC
/
