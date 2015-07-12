#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

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
 		if $full_access == true
 			then
 				echo "alter  ROLE $dbusername with superuser; " >> /tmp/.c.sql
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
	

