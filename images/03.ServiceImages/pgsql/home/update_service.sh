#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

BTICK='`'

E_BADARGS=65

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
		
if test -z $dbpassword
 then
	echo Error:No dbpassword value
	exit -1
fi
	
if test -z $encoding
 then
	echo Error:No encoding value
	exit -1
fi
	
echo  "Alter ROLE $dbusername WITH ENCRYPTED PASSWORD '$dbpassword'  LOGIN;" >/tmp/.c.sql


if ! test -z $full_access
 then
	if test $full_access == true
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

psql < /tmp/.c.sql

if test $? -ge 0
 then 
	echo "Success"
	rm /tmp/.c.sql
	exit 0
fi
	
echo "Error:"
exit -1
	

