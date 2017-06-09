#!/bin/bash
if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env

if test -z $parent_engine
	then
		echo Error:No parent_engine value
		exit -1
	fi

kill -TERM `cat /var/run/redis-server.$parent_engine.pid`
rm /home/config/$parent_engine.redis.config

if test $? -ge 0
	then 
		echo "Success"
		
		exit 0
	fi
	
	echo "Error:"
	exit -1
	
	RM SERVICE{:raw=>"", :stdout=>"", :stderr=>"cat: /var/run/redis-server.mgmt.pid: No such file or directory\nkill: usage: kill [-s sigspec | -n signum | -sigspec] pid | jobspec ... or kill -l [sigspec]\n/home/rm_service.sh: line 26: unexpected EOF while looking for matching ``'\n/home/rm_service.sh: line 37: syntax error: unexpected end of file\n", :result=>2}
	
	
