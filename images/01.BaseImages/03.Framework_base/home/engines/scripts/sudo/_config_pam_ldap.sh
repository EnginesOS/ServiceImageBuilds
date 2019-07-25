#!/bin/sh
cat /home/engines/templates/ldap.conf >/etc/ldap.conf
cp /home/engines/templates/copmmon
echo "session optional pam_mkhomedir.so skel=/etc/skel umask=077" >> /etc/pam.d/common-session