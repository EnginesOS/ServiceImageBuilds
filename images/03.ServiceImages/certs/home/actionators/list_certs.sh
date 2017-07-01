#!/bin/bash

if test -d /home/certs/store/public/certs/
 then
 
  echo -n '{"certs":['
  i=0
  
   cd /home/certs/store/public/certs/
  certs=`find . -name "*.crt" |grep -v default | sed "/\.crt/s///g"`
  
  for cert in $certs
   do
 	if test $i -eq 0
 	 then
 		i=1
 	else
 		echo -n ,
 	fi
  echo -n '"'$cert'"'
  done

 echo -n ']}'
fi
  
