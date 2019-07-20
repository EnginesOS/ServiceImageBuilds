#!/bin/sh


. /home/engines/functions/trap.sh
startup_complete

wait
exit_code=$?
/home/app/nginx-ldap-auth-daemon.py --host 0.0.0.0\
									-b "ou=people,dc=engines,dc=internal"\
									-u ldap://ldap:389 \
									 -D $ldap_dn\
									 -w $ldap_password &
									
									 
shutdown_complete
