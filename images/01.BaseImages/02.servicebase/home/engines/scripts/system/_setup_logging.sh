#!/bin/sh

if test -f /home/engines/etc/LOG_DIR
 then
	log_dir=`cat /home/engines/etc/LOG_DIR`
else
 	log_dir=/var/log/
fi
 	
if ! test -d $log_dir 
 then    
  mkdir -p $log_dir 
fi 

if ! test -f /home/engines/run/flags/log_setup
 then
  chown -R $ContUser $log_dir 
  touch /home/engines/run/flags/log_setup
fi

  
  