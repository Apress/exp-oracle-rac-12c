set lines 120
select n1, 
dbms_rowid.rowid_relative_fno (rowid) fno,
dbms_rowid.rowid_block_number(rowid) block, 
dbms_rowid.rowid_object(rowid) obj, 
v1
 from rs.t_one where n1=100;
