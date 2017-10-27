#!/bin/bash



PID_FILE=/var/run/engines/redis-server.pid
export PID_FILE
. /home/engines/functions/trap.sh


if test -f /home/engines/run/flags/restart_required
 then
  rm -f /home/engines/run/flags/restart_required
fi


touch /home/engines/run/flags/startup_complete

configs=`ls /home/config/*.redis.config`
for config in $configs
 do
    redis-server $config &
	echo -n $! >> $PID_FILE
	echo -n " " >> $PID_FILE
done
touch /home/engines/run/flags/startup_complete
 
# if test `ls /home/config/*.redis.config |wc -l` -eq 0
 # then
  while test 0 -ne 1
   do
	sleep 5 &
	wait
    exit_code=$?
	
	if test ` ls /tmp/  new_service.* 2>/dev/null| wc -l ` -ne 0 
	then
		for service in ` ls /tmp/new_service.* |cut -f2 -d.`
		  do
		  	redis-server /home/config/$service.redis.config &
		  	echo -n $!  > /var/run/engines/redis-server.$parent_engine.pid
		  done
	fi
   done	
 #  else
    
 # fi




rm /home/engines/run/flags/startup_complete
exit $exit_code
