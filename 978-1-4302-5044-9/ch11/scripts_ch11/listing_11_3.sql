col inst_id format 99
col owner_node format 99 head 'Owner|Node'

SELECT inst_id, pid, resource_name1, state, owner_node, blocked, blocker
FROM gv$ges_blocking_enqueue
ORDER BY resource_name1;
