#!/bin/bash


echo -n '{"certs":['
 for cert_type in `ls /home/certs/store`
  do
  if test -d /home/certs/store/$cert_type/certs/
   then
    i=0
    cd /home/certs/store/$cert_type/certs/
    certs=`find . -name "*.crt" |grep -v default | sed "/\.crt/s///g"`
      for cert in $certs
       do
      	if test $i -eq 0
      	 then
      		i=1
      	else
      		echo -n ,
      	fi
      	store=`dirname $cert |sed "/^\.\//s///"`
      	cert=`basename $cert`
        echo -n '{"cert_name":"'$cert'","store":"'$store'", "cert_type","'$cert_type'"}'
      done
  fi
  done
echo -n ']}'  
exit 0