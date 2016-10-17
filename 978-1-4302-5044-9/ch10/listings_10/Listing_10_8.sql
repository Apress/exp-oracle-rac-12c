SELECT 
  DECODE(state,0,'free',1,'xcur',2,'scur',3,'cr', 4,'read',5,'mrec',
               6,'irec',7,'write',8,'pi', 9,'memory',10,'mwrite',
              11,'donated', 12,'protected', 13,'securefile', 14,'siop',
              15,'recckpt', 16, 'flashfree', 17, 'flashcur', 18, 'flashna') state,
  mode_held, le_addr, dbarfil, dbablk, cr_scn_bas, cr_scn_wrp , class
FROM sys.x$bh
WHERE obj= &&obj
AND dbablk= &&block
AND state!=0 ;

