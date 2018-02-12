#!/bin/bash

if test -z $1
 then
   kill -TERM ` cat /var/run/slapd.pid /var/run/saslauthd.pid`
   rm  /var/lib/ldap/{data,lock}.mdb
else
   ldapdelete -r $*
fi  

cat - | slapadd -F /etc/ldap/slapd.d