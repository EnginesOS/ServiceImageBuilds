#!/bin/sh


 . /home/engines/functions/checks.sh
BTICK='`'

E_BADARGS=65
MYSQL=`which mysql`

required_values="database_name db_username db_password collation"
check_required_values


char_set=`echo $collation | cut -f1 -d_`

if test -z "$char_set"
 then
 	char_set=utf8
fi

Q1="CREATE DATABASE IF NOT EXISTS ${BTICK}$database_name${BTICK}   DEFAULT CHARACTER SET $char_set
  DEFAULT COLLATE $collation ; Create User '$db_username'@'%' IDENTIFIED BY '$db_password';"

if ! test -z $full_access
 then
	if test $full_access = full
  	 then
 	   Q2="UPDATE mysql.user SET Super_Priv='Y' WHERE user='$db_username'; \
 	    GRANT ALL PRIVILEGES ON *.* TO  ${BTICK}$db_username${BTICK}@${BTICK}%${BTICK}; 
 	    FLUSH PRIVILEGES;"
    elif test $full_access = grant 
 	 then
 	   Q2="GRANT ALL  PRIVILEGES ON *.* TO ${BTICK}$db_username${BTICK}@${BTICK}%${BTICK} WITH GRANT OPTION;"	   
       Q3="Grant Create User on ${BTICK}$database_name${BTICK}.*  to '$db_username'@'%';"
 	fi
 	else
 	Q2="GRANT ALL PRIVILEGES ON ${BTICK}$database_name${BTICK}.* TO '$db_username'@'%';"
 fi

Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"

echo "$SQL" >/tmp/$database_name.sql

$MYSQL   -urma  -e "$SQL" 2>&1 > /tmp/res
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

