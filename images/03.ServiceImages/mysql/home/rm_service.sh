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
	# dont return error but include note
	echo $res | grep  "Unknown database"
if test $? -eq 0
 then 
	echo "Database $dbname Not Found"
	exit 0
fi
	
echo "Error:$res"
exit -1
