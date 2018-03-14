#!/bin/bash

PID_FILE=/home/engines/run/engines.pid	
export PID_FILE

if test -f /home/engines/functions/trap.sh 
 then
 . /home/engines/functions/trap.sh
 else
. /home/trap.sh
fi

cp /home/ruby_env /home/.env_vars
  for env_name in `cat /home/app.env `
  	do
   	  if ! test -z  "${!env_name}"
        then
  	      echo  "passenger_env_var $env_name \"${!env_name}\";" >> /home/.env_vars
  	  fi
  	done 

 nginx &
echo $! >  $PID_FILE
		
startup_complete
wait 
exit_code=$?
shutdown_complete
exit $exit_code
