#!/bin/sh
cat /home/engines/templates/ldap.conf | while read LINE
 do
    eval echo "$LINE" >> /tmp/ldap.conf
 done
 
 sudo -n /home/engines/scripts/sudo/_config_pam_ldap.sh