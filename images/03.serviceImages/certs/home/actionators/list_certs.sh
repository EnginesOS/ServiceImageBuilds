#!/bin/bash

if test -d /home/certs/store/public/certs/
 then
 cd /home/certs/store/public/certs/
 certs=`ls *.crt |sed "/\.crt/s///g"`
 echo '{"certs":['
 i=0
 	for cert in $certs
 		do
 			if test $i -eq 0
 				then
 				i=1
 			else
 				echo ,
 			fi
 			echo '"'$cert'"'
 		done
 	echo ']}'
 fi
  
