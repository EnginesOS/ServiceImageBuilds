#!/bin/sh
 
/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n &
kpid=$! 
/usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &

. /home/engines/functions/system_functions.sh


if test -f /home/engines/run/flags/first_just_run
 then
   sleep 5
  . /home/engines/scripts/first_run/create_keys_func.sh  
   echo addprinc -pw password  admin@ENGINES.INTERNAL | kadmin.local 
   create_init_keys
   rm /home/engines/run/flags/first_just_run
fi 

startup_complete

wait $kpid 	

exit_code=$?
 
shutdown_complete
