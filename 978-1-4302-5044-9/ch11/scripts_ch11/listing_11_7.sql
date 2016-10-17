SELECT chr(bitand(&&p1,-16777216)/16777215) || chr(bitand(&&p1,16711680)/65535) type,
     mod(&&p1, 16) md
     FROM dual 
/

