#!/bin/sh


 . /home/engines/functions/checks.sh
required_values="database_name dbusername dbpassword encoding"
check_required_values

		
	
echo  "CREATE ROLE $dbusername WITH ENCRYPTED PASSWORD '$dbpassword'  LOGIN;" >/tmp/.c.sql
if test $encoding = "ascii"
 then 
	echo "CREATE DATABASE $database_name OWNER = $dbusername ;" >> /tmp/.c.sql
else
	echo "CREATE DATABASE $database_name \
		with OWNER  $dbusername\
		Encoding 'UTF8'\
		TEMPLATE = template0;" >> /tmp/.c.sql			
			#LC_COLLATE = '$collation'\
  			#LC_CTYPE = '$collation'; >> /tmp/.c.sql			
fi
echo "alter  ROLE $dbusername login; " >> /tmp/.c.sql

if ! test -z $full_access
 then
	if test $full_access = true
 	 then
 	    echo "alter  ROLE $dbusername with superuser; " >> /tmp/.c.sql
 	fi
 fi

if ! test -z $debug
 then
	echo "$SQL"
fi

psql < /tmp/.c.sql  &> /tmp/res

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
	

