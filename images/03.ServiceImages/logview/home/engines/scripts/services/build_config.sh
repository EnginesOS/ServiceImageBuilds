#!/bin/bash

cat /home/engines/templates/logview/head > /home/app/config.user.php
n=0
for config_file in ` find /home/saved/ -type f`
	do 	 
		if test $n -gt 0
	 		then
	 			echo ',' >> /home/app/config.user.php
	 		fi 
	   cat $config_file >> /home/app/config.user.php
	   n=`expr $n + 1`
	done
echo '}
}
' >> /home/app/config.user.php