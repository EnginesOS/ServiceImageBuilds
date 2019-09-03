#!/bin/sh
echo '{"mailboxes":['
ls /var/mail/ | while read LINE
 do
  if test $n -ne 0
   then
    echo -n ,
   else
     n=1
  fi     
  echo -n '"'$LINE'"'
 done
 echo -n ']}'