#!/bin/sh

/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n 
/usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &


pid=$!
touch /engines/var/run/flags/startup_complete
echo "startup complete"
wait $pid
exit_code=$?
export exit_code
kill `cat /var/run/krb5admin.pid /var/run/krb5kdc.pid`
