#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="database_name dbusername"
check_required_values


#echo "$SQL"

echo "drop  DATABASE $database_name  ;" >> /tmp/.c.sql
echo "drop  ROLE $dbusername  ;" >> /tmp/.c.sql

psql < /tmp/.c.sql

if test $? -ge 0
 then 
	echo "Success"
	rm /tmp/.c.sql
	exit 0
fi
	
echo "Error:"
exit -1
