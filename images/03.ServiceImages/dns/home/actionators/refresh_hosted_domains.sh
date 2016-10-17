#!/bin/bash

if ! test -d /home/bind/domain_list/lan/
 then
 	exit
 fi
 
cd /home/bind/domain_list/lan/

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

  if test -z ${ip}
	then
		echo Error:Missing IP Address
        exit 128
    fi

for domain in `ls `
 do
   /home/add_service.sh :domain_name=$domain:ip=$ip:ip_type=lan:
 done