#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/smarthost

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env


        
        
   	if ! test -z $smarthost_hostname
	then 
		if ! test -z $smarthost_port
			then
				smarthost_port=25
		    fi

		echo "*	smtp:$smarthost_hostname:$smarthost_port"  > /etc/postfix/transport.smart
		cp /etc/postfix/transport.smart /etc/postfix/transport
		else
		    rm -r /etc/postfix/transport.smart
		    touch /etc/postfix/transport.smart
			echo "*	smtp:"  > /etc/postfix/transport
		fi 
		if test -f /home/configurators/saved/default_domain
		  then
		    domain=`cat /home/configurators/saved/default_domain`
		    echo "[$domain] :local" >> /etc/postfix/transport
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