#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env


 required_values="db_master_pass"
check_required_values

cat /home/tmpls/change_pass.tmpl | sed "/DBPASSWD/s//$db_master_pass/" | sed "/DBUSER/s//admin/"  > /tmp/change_pass_cmd.js
 pass=`cat  /data/db/.priv/db_master_pass`

mongo -p $pass -u admin --authenticationDatabase admin < /tmp/change_pass_cmd.js&> /tmp/res
res=`cat /tmp/res`



echo $res | grep -v ERROR
 
if test $? -eq 0
	then 
		echo -n $db_master_pass >  /data/db/.priv/db_master_pass
		chmod 600  /data/db/.priv/db_master_pass
		echo "Success"
		exit 0
	fi
	
	echo "Error:$res"
	exit -1


