#!/bin/sh


 . /home/engines/functions/checks.sh
BTICK='`'

E_BADARGS=65
MYSQL=`which mysql`


required_values="database_name db_username"
check_required_values



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
