#!/bin/sh


 . /home/engines/functions/checks.sh

required_values="database_name db_username db_password"
check_required_values

 
 cat /home/tmpls/create_db.tmpl | sed "/DBNAME/s//$database_name/" \
 								| sed "/DBUSER/s//$db_username/" \
 								| sed "/DBPASSWD/s//$db_password/"  > /tmp/create_cmd.js
 pass=`cat  /data/db/.priv/db_master_pass`		
 mongo -p $pass -u admin --authenticationDatabase admin < /tmp/create_cmd.js&> /tmp/res
res=`cat /tmp/res`

echo $res | grep -v ERROR
 
if test $? -eq 0
  then 
	echo "Success"
	exit 0
fi
	
echo "Error:$res"
exit -1

