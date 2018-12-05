#!/bin/sh


 . /home/engines/functions/checks.sh

required_values="dbusername dbpassword"
check_required_values

echo  "Alter ROLE $dbusername WITH ENCRYPTED PASSWORD '$dbpassword'  LOGIN;" >/tmp/.c.sql


if ! test -z $full_access
 then
	if test $full_access = true
 	 then
 	    echo "Alter  ROLE $dbusername with superuser; " >> /tmp/.c.sql
 	 else
 	    echo "Alter  ROLE $dbusername with nosuperuser; " >> /tmp/.c.sql     
 	fi
 fi

if ! test -z $debug
 then
	echo "$SQL"
fi

psql < /tmp/.c.sql &> /tmp/res

if test $? -ge 0
 then 
	echo "Success"
	rm /tmp/.c.sql
	exit 0
fi

res=`cat /tmp/res`
echo "Error:$res"
echo $SQL

exit -1
	

