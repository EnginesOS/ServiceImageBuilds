#!/bin/sh

 . /home/engines/functions/checks.sh  
     echo "smart_hostname=$smart_hostname
           smart_host_port=$smart_host_port
           smart_host_user=$smart_host_user
           smart_host_passwd=$smart_host_passwd" > /home/engines/scripts/configurators/saved/smarthost
     
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


if test -f /home/engines/scripts/configurators/saved/deliver_local
 then
  if test -f /home/engines/scripts/configurators/saved/domain
   then
    domain_name=`cat /home/engines/scripts/configurators/saved/domain`   
    echo "[$domain_name] :email.engines.internal" >> /home/postfix/transport
  fi
fi
    
if test -f /etc/postfix/maps/transport.over_ride
 then
  cat /etc/postfix/maps/transport.over_ride >> /etc/postfix/maps/transport
  fi
fi 
sudo -n /home/engines/scripts/engine/sudo/_postmap.sh transport

 
if ! test -z $mail_name
 then
  echo $mail_name > /etc/postfix/mailname
  sudo -n /home/engines/scripts/engine/sudo/_set_mailname.sh $mail_name
fi



if test -z $smart_host_passwd
 then 	
  rm /home/postfix/smarthost_passwd
else
 echo "$smart_hostname $smart_host_user:$smart_host_passwd" > /home/postfix/smarthost_passwd
fi
sudo -n /home/engines/scripts/engine/sudo/_transport_over_ride.sh
sudo -n /home/engines/scripts/engine/sudo/_postmap.sh smarthost_passwd     

exit 0