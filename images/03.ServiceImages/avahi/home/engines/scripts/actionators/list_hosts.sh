#!/bin/sh


echo -n '{"hosts":['
 if test -f /home/avahi/hosts_list
  then
first=1
cat /home/avahi/hosts_list | while read LINE
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