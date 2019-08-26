#!/bin/sh

echo -n '{"users":['
n=0
 ps -ax | grep proft | grep -v acc | cut -f3- -d: |grep -  | while read LINE
 do
  if test $n -ne 0
   then
    echo -n ,
   else
     n=1
  fi     
  echo -n '"'$LINE'"'
 done
 echo ']}'