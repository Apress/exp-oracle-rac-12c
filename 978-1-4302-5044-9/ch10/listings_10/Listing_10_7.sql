SELECT instance ||'->' || inst_id transfer,
  class,
  cr_block cr_blk,
  TRUNC(cr_block_time     /cr_block/1000,2) avg_Cr,
  current_block cur_blk,
  TRUNC(current_block_time/current_block/1000,2) avg_cur
FROM gv$instance_cache_transfer
WHERE cr_block >0 AND current_block>0
ORDER BY instance, inst_id, class
/

