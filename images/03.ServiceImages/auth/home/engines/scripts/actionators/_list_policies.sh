#!/bin/sh
n=0
echo -n '{"policies":['
for princ in `kadmin.local -q listpols`
 do  
   if test $n -ne 0
    then
     echo   -n ',"'$princ'"'
    else
      echo -n '"'$princ'"'
    fi
    n=1  
 done
 
 echo ']}'
 