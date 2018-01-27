#!/bin/bash

function get_alt_names 
{
names=`cat /home/certs/store/$cert_type/certs/$store/$cert.crt \
       | openssl x509 -text |grep DNS: | sed "s/DNS://g" | sed "s/,/ /g" `
       an=0
       for name in $names
        do
         if test $an -eq 0
          then
            alt_names="["
           an=1
          else
            alt_names=$alt_names","
          fi
          alt_names=$alt_names'"'$name'"'          
        done
        if test $an -eq 1
          then
            alt_names=$alt_names"]"
          else
              alt_names='""'
         fi 
}

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
      	get_alt_names
      	 common_name=`cat /home/certs/store/$cert_type/certs/$store/$cert.crt \
       | openssl x509 -noout -subject |sed "/^.*CN=/s///" | sed "/\*/s///" `
        echo -n '{"cert_name":"'$cert'","CN":"'$common_name'","alt_names":'$alt_names',"store":"'$store'", "cert_type":"'$cert_type'"}'
      done
  fi
  done
echo -n ']}'  
exit 0