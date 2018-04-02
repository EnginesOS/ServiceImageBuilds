#!/bin/sh

if ! test -f /home/engines/run/flags/log_setup
 then
  if test -f /home/engines/etc/LOG_DIR
   then
	 log_dirs=`cat /home/engines/etc/LOG_DIR`  
  fi

  for log_dir in $log_dirs
   do
     if ! test -d $log_dir 
      then    
       mkdir -p $log_dir 
     fi
    chown $ContUser $log_dir 
  done   
fi

if test -f /home/engines/etc/SYSLOG
 then
   if test -f /home/engines/run/rsyslogd.pid 
    then
     rm /home/engines/rsyslogd.pid
   fi 

  rsyslogd -i /home/engines/run/rsyslogd.pid
fi 

  
  