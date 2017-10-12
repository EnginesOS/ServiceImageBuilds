#!/bin/sh

/home/engines/scripts/_start_syslog.sh

/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n &
kpid=$! 
/usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &
pid=$!

#kpid=`cat /var/run/krb5kdc.pid `
 echo -n " $pid" >> /var/run/krb5kdc.pid 
echo "startup complete"
touch /engines/var/run/flags/startup_complete
sleep 5
 if test -f /engines/var/run/flags/first_run.done
  then
	wait $kpid 	
	exit_code=$?
	rm /engines/var/run/flags/startup_complete
	export exit_code
  else
   export kpid 	
 fi