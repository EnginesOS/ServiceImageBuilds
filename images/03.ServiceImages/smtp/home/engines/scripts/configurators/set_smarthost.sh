#!/bin/sh

. /home/engines/functions/checks.sh  

     echo "smart_hostname=$smart_hostname
           smart_host_port=$smart_host_port
           smart_host_user=$smart_host_user
           auth_type=$auth_type
           enabled=$enabled
           smart_host_passwd=$smart_host_passwd" > /home/engines/scripts/configurators/saved/smarthost
     
required_values="enabled"
check_required_values 


if test $enabled = true
 then
  required_values="smart_hostname auth_type"
  check_required_values
  if ! test -z $smart_host_port
    then
	 smart_host_port=25
  fi
  
 echo "*	smtp:$smart_hostname:$smart_host_port"  > /home/postfix/transport.smart
  if test -z $smart_host_passwd
   then 	
    rm /home/postfix/smarthost_passwd
  else
    echo "$smart_hostname $smart_host_user:$smart_host_passwd" > /home/postfix/smarthost_passwd
    sudo -n /home/engines/scripts/engine/sudo/_postmap.sh smarthost_passwd     
  fi   
else
	rm /home/postfix/transport.smart
	rm /home/postfix/transport
fi 

/home/engines/scripts/configurators/build_transport.sh
sudo -n /home/engines/scripts/configurators/sudo/_rebuild_main.sh
#
#if test -f /home/engines/scripts/configurators/saved/deliver_local
# then
#  if test -f /home/engines/scripts/configurators/saved/domain
#   then
#    domain_name=`cat /home/engines/scripts/configurators/saved/domain`   
#    echo "[$domain_name] :email.engines.internal" >> /home/postfix/transport
#  fi
#fi
#    
#if test -f /home/postfix/transport.over_ride
# then
#  cat /home/postfix/transport.over_ride >> /home/postfix/transport
#fi 
#
#sudo -n /home/engines/scripts/engine/sudo/_postmap.sh transport
# 
#
#exit 0
#