#!/bin/sh

if ! test -f /home/engines/run/flags/first_run.done
 then
   sudo -n /home/engines/scripts/first_run/_first_run.sh >/var/log/first_run.log
   sleep 4
   touch /home/engines/run/flags/first_run.stage1_done
fi   

/usr/sbin/krb5kdc -P /home/engines/run/krb5kdc.pid -n &
kpid=$! 
/usr/sbin/kadmind -P /home/engines/run/krb5admin.pid -nofork  &

. /home/engines/functions/system_functions.sh


if test -f /home/engines/run/flags/first_run.stage1_done
 then
  . /home/engines/scripts/first_run/create_keys_func.sh  
   echo addprinc -pw password  admin@ENGINES.INTERNAL | kadmin.local 
   create_init_keys
   rm /home/engines/run/flags/first_run.stage1_done
   touch /home/engines/run/flags/first_run.done
fi 

wait $kpid 	
startup_complete

exit_code=$?
 
shutdown_complete
