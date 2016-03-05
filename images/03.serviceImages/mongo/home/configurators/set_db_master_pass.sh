#!/bin/bash

service_hash=$1


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env
if test -z $db_password
 then 
 echo "NO Password""
	exit -1
 fi
cat /home/tmpls/change_pass.tmpl | sed "/DBPASSWD/s//$db_password/"  > /tmp/change_pass_cmd.js
 pass=`cat /home/configurators/saved/db_master_pass`
 mongo  mongo -p $pass -u $admin --authenticationDatabase "admin" /tmp/change_pass_cmd.js&> /tmp/res
res=`cat /tmp/res`

echo $res | grep -v ERROR
 
if test $? -eq 0
	then 
		echo "Success"
		exit 0
	fi
	
	echo "Error:$res"
	exit -1


