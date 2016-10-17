REM Derive a resource_name string from object_id 
col res  new_value resource_name
col master_node head 'Mast|node' format 99
col value_blk format a30
declare
begin
for c1 in  (
SELECT DISTINCT '[0x'
    ||trim(TO_CHAR(13, 'xxxxxxxx'))
    ||']'
    || '%'
    || '],[CI]%' res
FROM  dual
)
loop
-- Using the derived resource_name, identify all GES resources
 for c2  in(
  SELECT distinct inst_id, resource_name, master_node, value_blk, value_blk_state
  FROM gv$ges_resource WHERE resource_name LIKE c1.res
 )
 loop
   dbms_output.put_line ('Resource name '|| c2.resource_name || ', Master '||c2.master_node ||',Instance '|| c2.inst_id);
   dbms_output.put_line ('...Value  '|| c2.value_blk || ' State:'|| c2.value_blk_state);
 end loop;
 dbms_output.put_line ('-------------------');
 dbms_output.put_line ('Lock details...');
 dbms_output.put_line ('-------------------');
 for c2 in ( select distinct inst_id, resource_name1,  transaction_id0, pid, 
		state, owner_node , grant_level , request_level from gv$ges_enqueue
       where resource_name1 like c1.res)
 loop
   dbms_output.put_line ('Res name '|| c2.resource_name1 || ', owner '||c2.owner_node );
   dbms_output.put_line ('...Transaction_id0 '|| c2.transaction_id0 ||',Gr. lvl '||c2.grant_level|| ', Req Lvl '|| c2.request_level ||',State ' || c2.state );
 end loop;
end loop;
end;
/
