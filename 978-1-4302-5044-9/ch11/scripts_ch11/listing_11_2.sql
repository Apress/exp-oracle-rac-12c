REM First let us lock a small table in exclusive mode				
REM SQL #1
LOCK TABLE t1 IN exclusive MODE;
REM Query gv$lock to review single instance locks.
REM SQL #2
SELECT sid, type, id1, id2, lmode, request FROM gv$lock WHERE type='TM';	

REM Global resource is created with an unique resource name referring to 
REM object_id of the table.

REM SQL #3
SELECT inst_id, resource_name, master_node, on_convert_q, on_grant_q
FROM gv$ges_resource WHERE resource_name LIKE '[0xb6dff3]%TM%' ;

REM Locks are acquired on that global resource in an Exclusive mode.
REM SQL #4
BEGIN 							
   print_Table (q'#
    select  inst_id, resource_name1, grant_level, request_level,state, blocked, blocker from
    gv$ges_enqueue where resource_name1 like '[0xb6dff3]%TM%'
    #');
 END;
/
