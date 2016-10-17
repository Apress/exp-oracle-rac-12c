set serveroutput on size 1000000
declare
begin
for c1 in (
select 
'[0x'|| substr(kglnahsv, 1,8) || '][0x'|| substr(kglnahsv, 9, 8) || ']' res, 
 kglnaown owner, kglnaobj objname
 from  x$kglob where  kglnaobj like upper('&objname') 
)
loop
 dbms_output.put_line ('-------------------');
 dbms_output.put_line ('Object Details...' || c1.owner||'.'|| c1.objname);
 dbms_output.put_line ('-------------------');
 dbms_output.put_line ('-------------------');
 dbms_output.put_line ('Resource details...');
 dbms_output.put_line ('-------------------');
 for c2 in ( select resource_name,  master_node from v$ges_resource 
       where resource_name like '%'||c1.res||'%')
 loop
   dbms_output.put_line ('Resource name '|| c2.resource_name || ', Master '||c2.master_node );
 end loop;
 dbms_output.put_line ('-------------------');
 dbms_output.put_line ('Lock details...');
 dbms_output.put_line ('-------------------');
 for c2 in ( select  resource_name1,  transaction_id0, pid, state, owner_node , grant_level from v$ges_enqueue 
       where resource_name1 like '%'||c1.res||'%')
 loop
   dbms_output.put_line ('Res name '|| c2.resource_name1 || ', owner '||c2.owner_node );
   dbms_output.put_line ('...Transaction_id0 '|| c2.transaction_id0 ||',Level '||c2.grant_level|| ',State ' || c2.state );
 end loop;
end loop;
end;
/
