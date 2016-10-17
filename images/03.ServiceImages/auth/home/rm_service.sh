#!/bin/bash


if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env

if test -z $engine
	then
		echo "Error engine not set"
		exit -1
	fi
	
if test -z $service 
	then
	echo "Error service not set"
		exit -1
	fi	

if test -z $command 
	then
	echo "Error command not set"
		exit -1
	fi
	
	rm /home/auth/keys/${service}_${command}_authorized_keys	
	cat /home/auth/keys/*_authorized_keys > /home/auth/keys/authorized_keys
chmod og-rwx /home/auth/keys/authorized_keys	


if test `echo  ${command} |grep access |wc -c ` -gt 2 
	then 		
		echo "
		drop user 'auth_$service$'@'%' ;" | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname
		rm -r /home/auth/static/access/$service/access
	fi
#
echo "Success"
exit 0
