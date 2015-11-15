#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/smarthost

. /home/engines/scripts/functions.sh

load_service_hash_to_environment


echo $1 |grep = >/dev/null
        if test $? -ne 0
        then
                exit
        fi


        
        
   	if test  ${#smarthost_hostname} -gt 5
	then 
		if test 1 -lt ${#smarthost_port}
			then
				smarthost_port=25
		    fi

		echo "*	smtp:$smarthost_hostname:$smarthost_port"  > /etc/postfix/transport.smart
		cp /etc/postfix/transport.smart /etc/postfix/transport
		else
		    rm -r /etc/postfix/transport.smart
		    tocuh /etc/postfix/transport.smart
			echo "*	smtp:"  > /etc/postfix/transport
		fi 
		if test -f /home/configurators/saved/default_domain
		  then
		    domain=`cat /home/configurators/saved/default_domain`
		    echo "[$domain] :local" >> /etc/postfix/transport
		   fi
		    
		#chown root.root /etc/postfix/transport
		chmod 600 /etc/postfix/transport
		sudo postmap /etc/postfix/transport




 
 if test -n $mail_namedefaultdomain
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
sudo postmap   /etc/postfix/smarthost_passwd     

exit 0