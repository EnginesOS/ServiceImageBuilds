#!/bin/bash


. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/default_domain
parms_to_file_and_env

echo ${domain_name} >/home/engines/scripts/configurators/saved/domain

cat /home/engines/templates/generic | while read LINE
do
 eval echo $LINE >> /home/postfix/generic
done

echo "@*local  no-reply@${domain_name}" > /home/postfix/generic
echo "@localhost  no-reply@${domain_name}" >> /home/postfix/generic

sudo -n /home/engines/scripts/engine/_postmap.sh  generic
 
sudo -n /home/engines/scripts/engine/_set_mailname.sh smtp.${domain_name}
	
cp /home/engines/templates/transport /home/postfix/

if test `wc -c /etc/postfix/transport.smart | cut -f 1 -d" " ` -gt 4
 then
	cat /etc/postfix/transport.smart >> /home/postfix/transport 
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
