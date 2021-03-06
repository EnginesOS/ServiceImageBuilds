#!/bin/bash

. /home/engines/functions/system_functions.sh
export KRB5_KTNAME=/etc/krb5kdc/keys/ldap.keytab

saslauthd -a kerberos5 -d &> /var/log/sasl.log &
echo $! >/home/engines/run/saslauthd.pid

  
if ! test -f /home/engines/run/flags/init_ous_configured
 then
  /home/engines/scripts/first_run/init_ous_configured.sh &
fi  

ulimit -n 1024 
if test -f /home/engines/run/flags/debug_level
 then
  debug="-d `cat /home/engines/run/flags/debug_level`"
 else
   debug="-d 0"
fi  

/usr/sbin/slapd $debug -h "ldap://0.0.0.0/  ldapi:///" 
echo $! /home/engines/run/slapd.pid

