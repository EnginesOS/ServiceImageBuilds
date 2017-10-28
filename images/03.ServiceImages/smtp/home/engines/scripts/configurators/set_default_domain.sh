#!/bin/bash

function build_templated_mapfile {
cat /home/engines/templates/$map_file | while read LINE
do
 eval echo $LINE >> /home/postfix/$map_file
done
sudo -n /home/engines/scripts/engine/_postmap.sh  $map_file
}

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/default_domain
parms_to_file_and_env

echo ${domain_name} >/home/engines/scripts/configurators/saved/domain

for map_file in generic sender_canonical
do
 build_templated_mapfile
done
 
sudo -n /home/engines/scripts/engine/_set_mailname.sh smtp.${domain_name}
	
cp /home/engines/templates/transport /home/postfix/

if test -f /etc/postfix/transport.smart 
 then
  if test `wc -c /etc/postfix/transport.smart | cut -f 1 -d" " ` -gt 4
   then
	cat /etc/postfix/transport.smart >> /home/postfix/transport 
  fi
fi

if ! test -z $deliver_local 
 then
  if test  $deliver_local -eq 1 
   then                 
	 echo ${domain_name} :[email.engines.internal]	>> /home/postfix/transport 			
   fi
fi	
sudo -n /home/engines/scripts/engine/_postmap.sh transport


exit $?
