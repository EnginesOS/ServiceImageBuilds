#!/bin/sh



/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n &
kpid=$! 
/usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &
pid=$!

#kpid=`cat /var/run/krb5kdc.pid `
 echo -n " $pid" >> /var/run/krb5kdc.pid 
touch /engines/var/run/flags/startup_complete
echo "startup complete"
touch /engines/var/run/flags/startup_complete
 kill -0 $kpid
 if ! test $? -eq 0
  then 
  sleep 500
 fi  
wait $kpid
exit_code=$?
rm /engines/var/run/flags/startup_complete
export exit_code
kill `cat /var/run/krb5admin.pid /var/run/krb5kdc.pid`
