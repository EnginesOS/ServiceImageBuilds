#!/bin/sh

if  test -z "$ldap_dn" -o -z "$ldap_password"
 then
 echo no vars
  exit
fi


cat /home/engines/templates/etc/ldap.conf | while read LINE
  do
     eval echo "$LINE" >> /tmp/ldap.conf
  done

 sudo -n /home/engines/scripts/sudo/_config_pam_ldap.sh

