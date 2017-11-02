#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

BTICK='`'

E_BADARGS=65
MYSQL=`which mysql`

required_values="database_name db_username db_password collation"
check_required_values


char_set=`echo $collation | cut -f1 -d_`

if test -t "$char_set"
 then
 	char_set=utf8
fi

Q1="CREATE DATABASE IF NOT EXISTS ${BTICK}$database_name${BTICK}   DEFAULT CHARACTER SET $char_set
  DEFAULT COLLATE $collation ;"
Q2="GRANT ALL  PRIVILEGES ON ${BTICK}$database_name${BTICK}.* TO '$db_username'@'%' IDENTIFIED BY '$db_password';"
Q3="Grant Create User on *.* to '$db_username'@'%';"
Q4="FLUSH PRIVILEGES;"
if ! test -z $full_access
 then
	if test $full_access = true
  	 then
 	   Q5="UPDATE mysql.user SET Super_Priv='Y' WHERE user='$dbusername' AND host='%';"
    elif test $full_access = grant 
 	 then
 	   Q5="GRANT ALL  PRIVILEGES ON ${BTICK}$database_name${BTICK}.* TO '$db_username'@'%' IDENTIFIED BY '$db_password' WITH GRANT OPTION;"
 	fi
 fi

SQL="${Q1}${Q2}${Q3}${Q4}${Q5}"

#echo "$SQL"

$MYSQL   -urma  -e "$SQL" &> /tmp/res
res=`cat /tmp/res`

echo $res | grep -v ERROR
 
if test $? -eq 0
 then 
	echo "Success"
	exit 0
fi
	
echo "Error:$res"
echo with $SQL
exit 127

