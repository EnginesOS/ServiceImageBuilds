#!/bin/sh

if ! test -d /home/bind/domain_list/lan/
 then
 	exit
 fi
 
cd /home/bind/domain_list/lan/

 if ! test -f /home/engines/system/net/ip
  then
   echo Error:Missing IP Address file
        exit 2
 fi
        
ip=`cat /home/engines/system/net/ip`

  if test -z ${ip}
	then
		echo Error:Missing IP Address
        exit 128
    fi
  if test  ${ip} = false
	then
		echo Error:Missing IP Address
        exit 128
    fi


for domain_name in `ls `
 do
  type_path=domains
  export domain_name ip ip_type type_path
  /home/engines/scripts/services/add_service.sh 
 done
 
 