#!/bin/bash

service_hash=$1


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if ! test -d 
 then
 	mkdir -p /home/saved/$parent_engine/
 fi
echo `cat /home/tmpls/$log_type` > /home/saved/$parent_engine/$log_name 
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

