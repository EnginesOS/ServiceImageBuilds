#!/bin/sh

echo "session optional pam_mkhomedir.so skel=/etc/skel umask=077" >> /etc/pam.d/common-session &&\	
 mv /tmp/ldap.conf /etc/ldap.conf
 cp /home/engines/templates/etc/pam.d/* /etc/pam.d/
 cp /home/engines/templates/etc/nsswitch.conf  /etc/