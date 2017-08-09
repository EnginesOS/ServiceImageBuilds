#!/bin/sh



/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n & 
/usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &
pid=$!

kpid=`cat var/run/krb5kdc.pid `
 echo " $pid" >> $PID_FILE
touch /engines/var/run/flags/startup_complete
echo "startup complete"
wait $kpid
exit_code=$?
rm /engines/var/run/flags/startup_complete
export exit_code
kill `cat /var/run/krb5admin.pid /var/run/krb5kdc.pid`
