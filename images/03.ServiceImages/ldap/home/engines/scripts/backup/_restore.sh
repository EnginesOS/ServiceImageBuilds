#!/bin/bash
kill -TERM ` cat /var/run/slapd.pid /var/run/saslauthd.pid`
rm  /var/lib//ldap/{data,lock}.mdb
cat - | slapadd  -F /etc/ldap/slapd.d