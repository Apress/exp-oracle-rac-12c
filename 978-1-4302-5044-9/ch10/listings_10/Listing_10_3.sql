col owner format a30
col object_name format a30
set lines 160
WITH ash_gc AS
  (SELECT    /*+ materialize */ inst_id, event, current_obj#, COUNT(*) cnt
  FROM gv$active_session_history
  WHERE event=lower('&event')
  GROUP BY inst_id, event, current_obj#
  HAVING COUNT (*) > &threshold )
SELECT * FROM
  (SELECT inst_id, nvl( owner,'Non-existent') owner ,
           nvl ( object_name,'Non-existent') object_name, 
           nvl ( object_type, 'Non-existent') object_type,
           cnt, current_obj#
  FROM ash_gc a, dba_objects o
  WHERE (a.current_obj#=o.object_id (+))
  AND a.current_obj#  >=1
  UNION
  SELECT inst_id, '', '', 'Undo Header/Undo block', cnt, current_obj#
  FROM ash_gc a WHERE a.current_obj#=0
  UNION
  SELECT inst_id, '', '', 'Undo Block', cnt, current_obj#
  FROM ash_gc a
  WHERE a.current_obj#=-1
  )
ORDER BY cnt DESC 
/
