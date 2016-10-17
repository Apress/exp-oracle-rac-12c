REM create a table
CREATE TABLE t_libtest (n1 NUMBER );

REM dynamically populate a CLOB variable and try to parse it.
DECLARE
  v_sqltext CLOB;
  c1 NUMBER ;
BEGIN
  v_sqltext:= ' select a0.* from t_libtest a0';
  c1       := dbms_sql.open_cursor;
  FOR i    IN 1 .. 1024
  LOOP
    v_sqltext := v_sqltext ||' , t_libtest a'||i;
  END LOOP;
  dbms_output.put_line(v_sqltext);
  dbms_sql.parse( c1, v_sqltext, dbms_sql.native);
END;
/

