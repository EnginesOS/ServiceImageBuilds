#!/bin/bash



PID_FILE=/var/run/redis-server.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

if test -f /engines/var/run/flags/restart_required
 then
  rm -f /engines/var/run/flags/restart_required
fi


touch /engines/var/run/flags/startup_complete

configs=`ls /home/config/*.redis.config`
for config in $configs
 do
	redis-server $config &
	echo -n $! >> /var/run/redis-server.pid
	echo -n " " >> /var/run/redis-server.pid
done
touch /engines/var/run/flags/startup_complete
 
# if test `ls /home/config/*.redis.config |wc -l` -eq 0
 # then
  while test 0 -ne 1
   do
	sleep 5
	if test ` ls /tmp/  new_service.* | wc -l` -ne 0
	then
		for service in ` ls /tmp/new_service.* |cut -f2 -d.`
		  do
		  	redis-server /home/config/$service.redis.config &
		  done
	fi
   done	
   else
    
 # fi




rm /engines/var/run/flags/startup_complete
