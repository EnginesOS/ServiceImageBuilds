#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

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
