#!/bin/sh

echo -n '{"users":['
n=0
for user in `ls  /etc/sftp/authorized_keys/`
 do
   if test $n -eq 0
    then
     n=1
   else
    echo -n ,
  fi
   echo -n '"'$user'"'
  
 done
 echo ']}'
