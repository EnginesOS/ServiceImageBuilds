#!/bin/sh
n=0
echo -n '{"principles":['
for princ in `kadmin.local -q listprincs|grep -v "Authenticating as principal"`
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
 