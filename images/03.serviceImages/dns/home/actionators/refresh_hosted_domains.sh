#!/bin/bash

cd /home/bind/domain_list

service_hash=$1

. /home/engines/scripts/functions.sh

  if test -z ${ip}
	then
		echo Error:Missing IP Address
        exit 128
    fi

for domain in `ls `
 do
   /home/add_service.sh :domain_name=$domain:ip=$ip:
 done