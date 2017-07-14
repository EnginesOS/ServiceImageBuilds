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
 echo Error:No username"
  exit 127
fi  

if test -z $db_password
 then
	echo Error:No db_password value
	exit 127
fi   

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
exit 127

