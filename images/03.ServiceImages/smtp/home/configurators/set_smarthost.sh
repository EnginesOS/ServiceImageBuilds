Ghost is a lbog platfor#!/bin/bash

cat - >/home/configurators/saved/smarthost

cat /home/configurators/saved/smarthost | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env
        
        
if ! test -z $smart_hostname
 then 
   if ! test -z $smart_host_port
	then
		smart_host_port=25
   fi

   echo "*	smtp:$smart_hostname:$smart_host_port"  > /etc/postfix/transport.smart
   cp /etc/postfix/transport.smart /etc/postfix/transport
else
    rm -r /etc/postfix/transport.smart
    touch /etc/postfix/transport.smart
	echo "*	smtp:"  > /etc/postfix/transport
fi 

if test -f /home/configurators/saved/default_domain
  then
   cat /home/configurators/saved/default_domain | /home/engines/bin/json_to_env >/tmp/.2env
   . /tmp/.2env
    if test $deliver_local =eq 1
     then
      echo "[$domain_name] :email.engines.internal" >> /etc/postfix/transport
    fi
fi
    
#chown root.root /etc/postfix/transport
chmod 600 /etc/postfix/transport
sudo -n postmap /etc/postfix/transport




 
 if ! test -z $mail_name
 then
 	echo $mail_name > /etc/postfix/mailname
 fi
 
 if test -z $smarthost_username -a -z $smarthost_password
 then 
 	if test -f /etc/postfix/smarthost_passwd
 	  then
 		rm /etc/postfix/smarthost_passwd
 	fi 	
 	if test -f /etc/postfix/smarthost_passwd.db
 	  then
 		rm /etc/postfix/smarthost_passwd.db
 	fi 
 	exit
fi
 
if test -z $smarthost_password
 then 
 	exit
 fi

echo "$smarthost_hostname $smarthost_username:$smarthost_password" > /etc/postfix/smarthost_passwd
#chown  /etc/postfix/smarthost_passwd
chmod 600 /etc/postfix/smarthost_passwd
sudo -n postmap   /etc/postfix/smarthost_passwd     

exit 0