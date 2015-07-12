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
	
if test -z $pubkey 
	then
	echo "Error pubkey not set"
		exit -1
	fi	
	
if test -z $command 
	then
	echo "Error command not set"
		exit -1
	fi
	
	

if  test $command = "access"
	then
		mkdir -p /home/auth/static/access/$service/
		cp /home/get_access.sh /home/auth/static/scripts/$service/
		chmod u+x /home/auth/static/scripts/$service/get_access.sh 
	
		echo "command=\"/home/auth/static/scripts/$service/get_access.sh\",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa $pubkey auth" >  /home/auth/static/keys/${service}_${command}_authorized_keys	
	
		pass=`dd if=/dev/urandom count=6 bs=1  | od -h | awk '{ print $2$3$4}'`
		echo "
			create user 'auth_$service'@'%' identified by '$pass';
			GRANT SELECT,INSERT,UPDATE on auth.* to 'auth_$service'@'%';" | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 
	
		echo ":db_username=auth_$service:db_password=$pass:database_name=$dbname:db_host=$dbhost:" > /home/auth/static/access/$service/access
		
	else
			echo "command=\"/home/auth/static/scripts/${service}/${command}_service.sh\",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa $pubkey auth" >  /home/auth/static/keys/${service}_${command}_authorized_keys	
	fi

#
cat /home/auth/static/keys/*_authorized_keys > /home/auth/static/keys/authorized_keys
chmod og-rwx /home/auth/static/keys/authorized_keys	

echo "Success"
exit 0
