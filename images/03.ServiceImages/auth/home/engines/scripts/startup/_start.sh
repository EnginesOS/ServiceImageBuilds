#!/bin/sh

PID_FILE=/var/run/krb5kdc.pid 
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_kerberos.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh
 

/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n &
kpid=$! 
/usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &
pid=$!
echo -n " $pid" >> /var/run/krb5kdc.pid

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
 /home/engines/scripts/signal/_kill_kerberos.sh TERM	

shutdown_complete
