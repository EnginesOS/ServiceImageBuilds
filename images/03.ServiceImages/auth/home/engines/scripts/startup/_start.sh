#!/bin/sh
 
/usr/sbin/krb5kdc -P /home/engines/run/krb5kdc.pid -n &
kpid=$! 
/usr/sbin/kadmind -P /home/engines/run/krb5admin.pid -nofork  &

. /home/engines/functions/system_functions.sh


if ! test -f /home/engines/run/flags/first_run.done
 then
 	/home/engines/scripts/first_run/_first_run.sh >/var/log/first_run.log
   sleep 5
  . /home/engines/scripts/first_run/create_keys_func.sh  
   echo addprinc -pw password  admin@ENGINES.INTERNAL | kadmin.local 
   create_init_keys
   rm /home/engines/run/flags/first_just_run
   touch /home/engines/run/flags/first_run.done
fi 



wait $kpid 	

exit_code=$?
 
shutdown_complete
