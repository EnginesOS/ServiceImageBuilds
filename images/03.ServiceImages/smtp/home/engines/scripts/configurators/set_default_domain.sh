#!/bin/bash


. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/default_domain
parms_to_file_and_env

echo ${domain_name} >/home/engines/scripts/configurators/saved/domain

echo "@*local  no-reply@${domain_name}" > /etc/postfix/generic
echo "@localhost  no-reply@${domain_name}" >> /etc/postfix/generic
sudo -n postmap  /etc/postfix/generic
        
       # echo "/.+/ @${domain_name}" > /etc/postfix/sender_canonical
       # postmap  /etc/postfix/sender_canonical

postconf -e myhostname=smtp.${domain_name}
echo smtp.${domain_name} > /etc/postfix/mailname
	
if test `wc -c /etc/postfix/transport.smart | cut -f 1 -d" " ` -gt 4
 then
	cp /etc/postfix/transport.smart /etc/postfix/transport 
else
  	echo  "*	:" > /etc/postfix/transport
fi
if ! test -z $deliver_local 
 then
  if test  $deliver_local -eq 1 
   then                 
	 echo ${domain_name} :[email.engines.internal]	>> /etc/postfix/transport 			
   fi
fi	
sudo -n postmap /etc/postfix/transport
 
exit $?
