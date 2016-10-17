set lines 120
col kjblname format a30
col kjblname2 format a20
col kjblgrant format a10
col kjblrole format 9999
col kjblrequest format A10
set verify off
select /*+ leading (c a b ) */ b.kjblname, b.kjblname2 , 
b.kjblgrant, b.kjblrole, b.kjblrequest , b.kjblmaster, b.kjblowner
from x$le a , x$kjbl b, x$bh c
where a.le_kjbl = b.kjbllockp
and a.le_addr =c.le_addr
and dbablk=&&block and obj=&&obj --and utl_raw.length(c.le_addr) >1 
;
