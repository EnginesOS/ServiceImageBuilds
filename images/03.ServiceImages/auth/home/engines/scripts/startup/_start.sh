#!/bin/sh

/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n &
kpid=$! 
/usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &
pid=$!
echo -n " $pid" >> /var/run/krb5kdc.pid
 
startup_complete

#sleep 5
# if test -f /home/engines/run/flags/first_run.done
#  then
	wait $kpid 	
	exit_code=$?
	/home/engines/scripts/signal/_kill_kerberos.sh TERM
	
    shutdown_complete
#	
#	export exit_code
#  else
#   export kpid 	
# fi