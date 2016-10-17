SELECT inst_id,
  TRUNC(data_requests /tot_req,2) * 100 data_per,
  TRUNC(undo_requests /tot_req,2) * 100 undo_per,
  TRUNC(tx_requests   /tot_req,2) * 100 tx_per,
  TRUNC(other_requests/tot_req,2) * 100 other_per
FROM
  (SELECT inst_id, cr_Requests + current_Requests tot_req,
    data_requests, undo_requests, tx_requests, other_requests
    FROM gv$cr_block_server
   )
ORDER BY inst_id
/

