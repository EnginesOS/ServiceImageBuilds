#!/bin/sh


touch /engines/var/run/flags/startup_complete
/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n & 
/usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &
pid=$!

kpid=`cat /var/run/krb5kdc.pid `
 echo -n " $pid" >> /var/run/krb5kdc.pid 
touch /engines/var/run/flags/startup_complete
echo "startup complete"
wait $kpid
exit_code=$?
rm /engines/var/run/flags/startup_complete
export exit_code
kill `cat /var/run/krb5admin.pid /var/run/krb5kdc.pid`
