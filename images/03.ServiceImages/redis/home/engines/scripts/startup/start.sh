#!/bin/bash

PID_FILE=/home/engines/run/redis-server.pid
export PID_FILE
. /home/engines/functions/trap.sh


service_clear_restart_required
if ! test -d /home/redis/config.d/
 then
	mkdir /home/redis/config.d/
fi	

if test `ls /home/redis/config.d/*.redis.config |wc -l` -gt 0
 then
	configs=`ls /home/redis/config.d/*.redis.config`
	 for config in $configs
      do
       redis-server $config &
	   echo -n $! >> $PID_FILE
	   echo -n " " >> $PID_FILE
     done
fi     

startup_complete
 
# if test `ls /home/redis/config.d/*.redis.config |wc -l` -eq 0
 # then

 while ! test -f /home/engines/run/flags/sig_term -o -f /home/engines/run/flags/sig_quit 
   do
	sleep 5 &
	wait
    exit_code=$?
	
	if test ` ls /tmp/new_service.* 2>/dev/null| wc -l ` -ne 0 
	then
		for service in ` ls /tmp/new_service.* |cut -f2 -d.`
		  do
		  	redis-server /home/redis/config.d/$service.redis.config &
		  	echo -n $!  > /home/engines/run/redis-server.$parent_engine.pid
		  done
	fi
 done
   	
   for pid_file in `ls /home/engines/run/redis-server.*.pid`
    do
     kill -$SIGNAL `cat /home/engines/run/$pid_file`
   done

shutdown_complete

