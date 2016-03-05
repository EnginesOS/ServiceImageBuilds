#!/bin/bash
db_password=`dd if=/dev/urandom count=6 bs=1  | od -h | awk '{ print $2$3$4}'`
echo $db_password > /home/configurators/saved/db_master_pass
cat /home/tmpls/first_run.tmpl | sed "/DBPASSWD/s//$db_password/"  > /tmp/first_run.js
 mongo  /tmp/first_run.js&> /tmp/res
res=`cat /tmp/res`

echo $res | grep -v ERROR
 
if test $? -eq 0
	then 
		echo "Success"
		exit 0
	fi
	
	echo "Error:$res"
	exit -1
	 touch /engines/var/run/flags/first_run_done

	 
