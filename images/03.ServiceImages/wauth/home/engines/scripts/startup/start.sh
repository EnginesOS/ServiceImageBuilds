#!/bin/sh


/usr/sbin/nginx &

startup_complete

wait
exit_code=$?
/home/app/nginx-ldap-auth-daemon.py -h 0.0.0.0\
									-b "ou=people,dc=engines,dc=internal"\
									-u ldap://ldap:389 \
									 -f uid=%(username)s) \
									 -D $ldap_dn\
									 -w $ldap_password
									 
shutdown_complete
