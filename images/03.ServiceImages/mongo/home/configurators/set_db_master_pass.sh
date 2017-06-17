#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z $db_master_pass
 then 
 echo "NO Password"
	exit -1
 fi
 
cat /home/tmpls/change_pass.tmpl | sed "/DBPASSWD/s//$db_master_pass/" | sed "/DBUSER/s//admin/"  > /tmp/change_pass_cmd.js
 pass=`cat  /data/db/.priv/db_master_pass`

   mongo -p $pass -u admin --authenticationDatabase admin < /tmp/change_pass_cmd.js&> /tmp/res
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


