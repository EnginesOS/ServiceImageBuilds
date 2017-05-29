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



if test -z $parent_engine
	then
		echo Error:No parent_engine value
		exit -1
	fi

kill -TERM `cat /var/run/redis-server.$parent_engine.pid`
rm /home/config/$parent_engine.redis.config`

if test $? -ge 0
	then 
		echo "Success"
		
		exit 0
	fi
	
	echo "Error:"
	exit -1
