#!/bin/bash
if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env


BTICK='`'

E_BADARGS=65
MYSQL=`which mysql`



if test -z $database_name
	then
		echo Error:No database_name value
		exit -1
	fi
	
if test -z $dbusername
	then
		echo Error:No dbusername value
		exit -1
	fi




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
