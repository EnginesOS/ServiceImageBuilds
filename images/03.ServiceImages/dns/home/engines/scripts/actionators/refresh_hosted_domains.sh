#!/bin/sh

if ! test -d /home/bind/domain_list/lan/
 then
 	exit
 fi
 
cd /home/bind/domain_list/lan/

ip=$2


  if test -z ${ip}
	then
		echo Error:Missing IP Address
        exit 128
    fi

for domain in `ls `
 do
   echo '{"domain_name":"'$domain'","ip":"'$ip'","ip_type":"lan"}' | /home/add_service.sh 
   #:domain_name=$domain:ip=$ip:ip_type=lan:
 done