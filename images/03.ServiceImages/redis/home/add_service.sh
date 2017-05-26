#!/bin/bash

if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env


if test -z $port
	then
		echo Error:No port value
		exit -1
	fi
	

if test -z $password
	then
		echo Error:No password value
		exit -1
	fi
	
	cat /home/tmpl/redis.tmpl | sed "s/PORT/$port/" | sed "s/PASSWORD/$password/" | sed "s/ENGINE/$parent_engine/"> /home/config/$parent_engine.redis
	redis_server /home/config/$parent_engine.redis.config

if test $? -ge 0
	then 
		echo "Success"
		
		exit 0
	fi
	
	echo "Error:"
	exit -1
	

