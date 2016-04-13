#!/bin/bash

cat /home/tmpls/head > /home/app/config.user.php
n=0
for config_file in ` find /home/saved/ -type f`
	do 
	  n=`expr $n + 1`
		if test $n -gt 0
	 		then
	 			echo ',' >> /home/app/config.user.php
	 		fi 
	   cat $config_file >> /home/app/config.user.php
	done
echo '}\
}\
' >> /home/app/config.user.php