#!/bin/sh

cp /home/engines/templates/common-password /etc/pam.d
echo "session optional pam_mkhomedir.so skel=/etc/skel umask=077" >> /etc/pam.d/common-session
rm /etc/ldap.con

cat /home/engines/templates/ldap.conf | while read LINE
 do
    eval echo "$LINE" >> /etc/ldap.conf
 done
 
 