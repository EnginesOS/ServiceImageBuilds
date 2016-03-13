#!/bin/bash

service_hash=$1


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env
if test -z $db_master_pass
 then 
 echo "NO Password"
	exit -1
 fi
 
cat /home/tmpls/change_pass.tmpl | sed "/DBPASSWD/s//$db_master_pass/"  > /tmp/change_pass_cmd.js

 pass=`cat  /data/db/.priv/db_master_pass`

 mongo  mongo -p $pass -u admin --authenticationDatabase admin < /tmp/change_pass_cmd.js&> /tmp/res
res=`cat /tmp/res`



echo $res | grep -v ERROR
 
if test $? -eq 0
	then 
		echo -n $db_master_pass >  /data/db/.priv/db_master_pass
		echo "Success"
		exit 0
	fi
	
	echo "Error:$res"
	exit -1


