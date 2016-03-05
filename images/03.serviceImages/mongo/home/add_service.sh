#!/bin/bash

service_hash=$1




 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env



if test -z $database_name
	then
		echo Error:No database_name value
		exit -1
	fi
	
if test -z $db_username
	then
		echo Error:No db_username value
		exit -1
	fi
		
if test -z $db_password
	then
		echo Error:No db_password value
		exit -1
	fi


 
 cat /home/tmpls/create_db.tmpl | sed "/DBNAME/s//$database_name/" \
 								| sed "/DBUSER/s//$db_username/" \
 								| sed "/DBPASSWD/s//$db_password/"  > /tmp/create_cmd.js
 pass=`cat /home/configurators/saved/db_master_pass`		
 mongo -p $pass -u $admin  /tmp/create_cmd.js&> /tmp/res
res=`cat /tmp/res`

echo $res | grep -v ERROR
 
if test $? -eq 0
	then 
		echo "Success"
		exit 0
	fi
	
	echo "Error:$res"
	exit -1

