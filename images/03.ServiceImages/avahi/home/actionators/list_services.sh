#!/bin/bash

/home/avahi/services_list

echo -n '{"services":['
first=1
 if test -f /home/avahi/services_list
  then
cat /home/avahi/services_list | while read LINE
do
 if test -z "$LINE"
  then
   continue
  fi
  if test $first -ne 1
   then
    echo ,
    else 
    first=0
   fi 
  echo -n '"'$LINE'"'
done
 fi
echo ']}'