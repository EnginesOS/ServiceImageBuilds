#!/bin/sh

 . /home/engines/functions/checks.sh  
     echo "smart_hostname=$smart_hostname
           smart_host_port=$smart_host_port
           smarthost_username=$smarthost_username
           smarthost_password=$smarthost_password" >> /home/engines/scripts/configurators/saved/smarthost
       
     
     
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
    
    if test -f /etc/postfix/maps/transport.over_ride
 then
  cp /etc/postfix/maps/transport.over_ride /etc/postfix/maps/transport
  if test -f /etc/postfix/transport.smart 
   then
    if test `wc -c /etc/postfix/transport.smart | cut -f 1 -d" " ` -gt 4
     then
	   cat /etc/postfix/transport.smart >> /home/postfix/maps/transport 
    fi
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
sudo -n /home/engines/scripts/engine/_transport_over_ride.sh
sudo -n /home/engines/scripts/engine/_postmap.sh smarthost_passwd     

exit 0