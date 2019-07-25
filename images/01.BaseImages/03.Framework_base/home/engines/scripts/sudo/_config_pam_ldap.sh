#!/bin/sh

cp /home/engines/templates/common-password /etc/pam.d
echo "session optional pam_mkhomedir.so skel=/etc/skel umask=077" >> /etc/pam.d/common-session


 mv /tmp/ldap.conf /etc/ldap.conf
 