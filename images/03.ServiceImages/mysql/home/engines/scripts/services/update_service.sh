#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="database_name db_username db_password"
check_required_values

BTICK='`'

E_BADARGS=65
MYSQL=`which mysql`

Q1="set password for '"$db_username"'@'%' = PASSWORD('"$db_password"');"	


if ! test -z $full_access
 then
   if test $full_access = true
 	then
 	  Q5="UPDATE mysql.user SET Super_Priv='Y' WHERE user='$db_username' AND host='%';"
   elif test $full_access = grant 
     then
       Q5="UPDATE mysql.user SET Super_Priv='N' WHERE user='$dbusername' AND host='%';"
  		Q5=$Q5 "GRANT ALL PRIVILEGES ON ${BTICK}$database_name${BTICK}.* TO '$db_username'@'%' IDENTIFIED BY '$db_password' WITH GRANT OPTION;"
    else	     
 	   Q5=$Q5 "REVOKE GRANT ON ${BTICK}$database_name${BTICK}.* TO '$db_username'@'%' IDENTIFIED BY '$db_password' ;"
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
echo  With $SQL
exit 127

