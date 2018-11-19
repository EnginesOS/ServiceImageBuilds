#!/bin/sh
n=0
echo -n '{"policies":['
for pol in `kadmin.local -q listpols |grep -v "Authenticating as principal"`
 do  
   if test $n -ne 0
    then
     echo   -n ',"'$pol'"'
    else
      echo -n '"'$pol'"'
    fi
    n=1  
 done
 
 echo ']}'
 