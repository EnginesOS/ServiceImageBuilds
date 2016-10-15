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
	
		echo "command=\"/home/auth/static/scripts/$service/get_access.sh\",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa $pubkey auth" >  /home/auth/keys/${service}_${command}_authorized_keys	
	
		pass=`dd if=/dev/urandom count=6 bs=1  | od -h | awk '{ print $2$3$4}'`
		echo "create user 'auth_$service'@'%' identified by '$pass';;" | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 
		echo "SET PASSWORD FOR 'auth_ftp'@'%' = password('$pass');" | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 
		echo "GRANT SELECT on auth.* to 'auth_$service'@'%';" | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 
		echo "create user 'auth_$service'@'%' identified by '$pass';
			SET PASSWORD FOR 'auth_ftp'@'%' = password('$pass');
			GRANT SELECT on auth.* to 'auth_$service'@'%'; | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname " >>/tmp/add_access.log
		#echo ":db_username=auth_$service:db_password=$pass:database_name=$dbname:db_host=$dbhost:" > /home/auth/static/access/$service/access
		echo '{"db_username":"auth_'$service'","db_password":"'$pass'","database_name":"'$dbname'","db_host":"'$dbhost'"}' > /home/auth/static/access/$service/access
		
	else
			echo "command=\"/home/auth/static/scripts/${service}/${command}_service.sh\",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa $pubkey auth" >  /home/auth/keys/${service}_${command}_authorized_keys	
	fi

#
cat /home/auth/keys/*_authorized_keys > /home/auth/keys/authorized_keys
chmod og-rwx /home/auth/keys/authorized_keys	

echo "Success"
exit 0
