col inst format 9999 
col current_file# format 99999  head file
col current_block# format 9999999 head blk
WITH ash_gc AS
  (SELECT * FROM
    (SELECT /*+ materialize */ inst_id, event, current_obj#, current_file#,
      current_block#, COUNT(*) cnt
    FROM gv$active_session_history
    WHERE event=lower('&event')
    GROUP BY inst_id, event, current_obj#,
      current_file#, current_block#
    HAVING COUNT(*) >5
    )
  WHERE rownum <101
  )
SELECT * FROM
  (SELECT inst_id, owner, object_name, object_type, current_file#,
    current_block#, cnt
  FROM ash_gc a, dba_objects o
  WHERE (a.current_obj#  =o.object_id (+))
  AND a.current_obj#  >=1
  UNION
  SELECT inst_id, '', '', 'Undo Header/Undo block' ,
    current_file#, current_block#, cnt
  FROM ash_gc a
  WHERE a.current_obj#=0
  UNION
  SELECT inst_id, '', '', 'Undo Block' ,
    current_file#, current_block#, cnt
  FROM ash_gc a
  WHERE a.current_obj#=-1
  )
ORDER BY 7 DESC 
/
