#!/bin/bash


. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/smarthost
parms_to_file_and_env
        
if ! test -z $smart_hostname
 then 
   if ! test -z $smart_host_port
	then
		smart_host_port=25
   fi

   echo "*	smtp:$smart_hostname:$smart_host_port"  > /home/postfix/transport.smart
   cp /etc/postfix/transport.smart /home/postfix/transport
else
    rm -r /etc/postfix/transport.smart
    touch /etc/postfix/transport.smart
	echo "*	smtp:"  > /home/postfix/transport
fi 

sudo -n /home/engines/scripts/engine/_postmap.sh transport
if test -f /home/engines/scripts/configurators/saved/default_domain
  then
   cat /home/engines/scripts/configurators/saved/default_domain | /home/engines/bin/json_to_env >/tmp/.2env
   . /tmp/.2env
    if test $deliver_local =eq 1
     then
      echo "[$domain_name] :email.engines.internal" >> /home/postfix/transport
    fi
fi
    
sudo -n /home/engines/scripts/engine/_postmap.sh transport

 
 if ! test -z $mail_name
 then
 	echo $mail_name > /etc/postfix/mailname
 fi
 sudo -n /home/engines/scripts/engine/_set_mailname.sh $mail_name
 
# if test -z $smarthost_username -a -z $smarthost_password
# then 
# 	if test -f /etc/postfix/smarthost_passwd
# 	  then
# 		rm /etc/postfix/smarthost_passwd
# 	fi 	
# 	if test -f /etc/postfix/smarthost_passwd.db
# 	  then
# 		rm /etc/postfix/smarthost_passwd.db
# 	fi 
# 	exit
#fi
# 
#if test -z $smarthost_password
# then 
# 	
# fi

echo "$smarthost_hostname $smarthost_username:$smarthost_password" > /home/postfix/smarthost_passwd


sudo -n /home/engines/scripts/engine/_postmap.sh smarthost_passwd     

exit 0