#!/bin/sh

if ! test -d /home/bind/domain_list/lan/
 then
 	exit
 fi
 
cd /home/bind/domain_list/lan/

 if test -f /home/engines/system/net/ip
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


for domain_name in `ls `
 do
  export domain_name ip ip_type
  /home/add_service.sh 
 done