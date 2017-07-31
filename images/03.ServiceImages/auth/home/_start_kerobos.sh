#!/bin/sh


#kdb5_ldap_util -D  cn=admin,dc=engines,dc=internal create -subtrees dc=engines,dc=internal -r ENGINES.INTERNAL -s -H ldap://ldap.engines.internal

#Password for "cn=admin,dc=engines,dc=internal": 
#Initializing database for realm 'ENGINES.INTERNAL'
#You will be prompted for the database Master Password.
#It is important that you NOT FORGET this password.
#Enter KDC database master key: 
#Re-enter KDC database master key to verify: 
#Enter DN of Kerberos container: cn=krbcontainer,dc=engines,dc=internal
 


/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n & 
/usr/sbin/kadmind -P /var/run/krb5admin.pid -nofork  &


pid=$!
touch /engines/var/run/flags/startup_complete
echo "startup complete"
wait $pid
exit_code=$?
export exit_code
kill `cat /var/run/krb5admin.pid /var/run/krb5kdc.pid`
