#!/bin/sh
cat /home/engines/etc/samba/smb.conf.ini /home/engines/etc/samba/smd.d/*cf > /etc/samb/smb.conf
echo $ldap_password > /etc/ldap.secret
smbpasswd -w $ldap_password