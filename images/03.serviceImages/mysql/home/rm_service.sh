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
	
if test -z $db_username
	then
		echo Error:No db_username value
		exit -1
	fi

Q1="DELETE FROM mysql.user where user='$db_username';"
Q2="FLUSH PRIVILEGES;"
Q3="Drop DATABASE  ${BTICK}$database_name${BTICK}   ;"
SQL="${Q1}${Q2}${Q3}"

#echo "$SQL"

$MYSQL   -urma  -e "$SQL"  $database_name &> /tmp/res
res=`cat /tmp/res`

echo $res | grep -v ERROR
 
if test $? -eq 0
	then 
		echo "Success"
		exit 0
	fi
	
	echo "Error:$res"
	exit -1
