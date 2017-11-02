#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="port password"
check_required_values


		
next_port=`cat /home/redis/next_port`
if test $port -gt $next_port
  then
	next_port=`expr $port + 1`
	echo $next_port > /home/redis/next_port
fi

cat /home/engines/templates/redis.conf.tmpl | sed "s/PORT/$port/" | sed "s/PASSWORD/$password/" | sed "s/ENGINE/$parent_engine/"> /home/redis/config.d/$parent_engine.redis.config
touch /tmp/new_service.$parent_engine


if test $? -ge 0
 then 
	echo "Success"		
	exit 0
fi
	
echo "Error:"
exit -1
	

