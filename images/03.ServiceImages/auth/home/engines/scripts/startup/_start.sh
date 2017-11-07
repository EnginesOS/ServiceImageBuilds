#!/bin/sh
 
/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n &
kpid=$! 
/usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &
pid=$!
echo -n " $pid" >> /var/run/krb5kdc.pid

. /home/engines/functions/system_functions.sh
startup_complete

if test -f /home/engines/run/flags/first_just_run
 then
   sleep 5
  . /home/engines/scripts/first_run/create_keys_func.sh  
   create_init_keys
   rm /home/engines/run/flags/first_just_run
fi 

 wait $kpid 	
 exit_code=$?

