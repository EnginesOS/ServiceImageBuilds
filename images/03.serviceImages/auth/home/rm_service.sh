#!/bin/bash


service_hash=`echo  "$*" | sed "/\*/s//STAR/g"`

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

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
	
	rm /home/auth/static/ssh/keys/${service}_${command}_authorized_keys	
	cat /home/auth/static/keys/*_authorized_keys > /home/auth/static/keys/authorized_keys
chmod og-rwx /home/auth/static/keys/authorized_keys	


if test `echo  ${command} |grep access |wc -c ` -gt 2 
	then 		
		echo "
		drop user 'auth_$service$'@'%' ;" | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname
		rm -r /home/auth/static/access/$service/access
	fi
#
echo "Success"
exit 0
