#!/bin/sh

if test -z $1
 then
   kill -TERM ` cat /home/engines/run/slapd.pid /home/engines/run/saslauthd.pid`
   rm  /var/lib/ldap/{data,lock}.mdb
else
   ldapdelete -r $*
fi  

cat - | slapadd -F /etc/ldap/slapd.d