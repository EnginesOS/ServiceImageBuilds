#!/bin/sh

PID_FILE=/var/run/krb5kdc.pid 
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_kerberos.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh
 
if test -f /home/engines/run/flags/first_just_run
 then
   rm /home/engines/run/flags/first_just_run
else   
 /usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n &
 kpid=$! 
 /usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &
 pid=$!
 echo -n " $pid" >> /var/run/krb5kdc.pid
 
 startup_complete

 #sleep 5
 if test -f /home/engines/run/flags/first_run.done
   then
	 wait $kpid 	
	 exit_code=$?
	 /home/engines/scripts/signal/_kill_kerberos.sh TERM
 fi	
fi 
shutdown_complete
