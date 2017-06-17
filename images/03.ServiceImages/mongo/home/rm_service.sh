#!/bin/bash
if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

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

cat /home/tmpls/destroy_db.tmpl | sed "/DBNAME/s//$database_name/" \
 								| sed "/DBUSER/s//$db_username/"  > /tmp/destroy_db_cmd.js
pass=`cat  /data/db/.priv/db_master_pass`		
mongo -p $pass -u admin --authenticationDatabase admin < /tmp/destroy_db_cmd.js&> /tmp/res
res=`cat /tmp/res`

echo $res | grep -v ERROR
 
if test $? -eq 0
 then 
 	echo "Success"
	exit 0
fi
	
echo "Error:$res"
exit -1

