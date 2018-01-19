#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/smarthost
parms_to_file_and_env
     
     
required_values="smart_hostname"
check_required_values 
   
if ! test -z $smart_hostname
 then 
   if ! test -z $smart_host_port
	then
		smart_host_port=25
   fi
   echo "*	smtp:$smart_hostname:$smart_host_port"  > /home/postfix/transport.smart
   cp /home/postfix/transport.smart /home/postfix/transport
else
	rm /home/postfix/transport.smart
	rm /home/postfix/transport
fi 
if test $deliver_local -eq 1
 then
  if test -f /home/engines/scripts/configurators/saved/domain
   then
    domain_name=`cat /home/engines/scripts/configurators/saved/domain`   
    echo "[$domain_name] :email.engines.internal" >> /home/postfix/transport
  fi
fi
    
sudo -n /home/engines/scripts/engine/_postmap.sh transport

 
if ! test -z $mail_name
 then
  echo $mail_name > /etc/postfix/mailname
fi

sudo -n /home/engines/scripts/engine/_set_mailname.sh $mail_name
 

if test -z $smarthost_password
 then 	
  rm /home/postfix/smarthost_passwd
else
 echo "$smarthost_hostname $smarthost_username:$smarthost_password" > /home/postfix/smarthost_passwd
fi

sudo -n /home/engines/scripts/engine/_postmap.sh smarthost_passwd     

exit 0