#!/bin/sh
	

files="ldap.conf"

for $file in files
 do
  cat /home/engines/templates/ftp/$file |\
  	 sed "s/LDAP_BIND_DN/$ldap_dn/"|\
  	  sed "s/LDAP_BIND_PW/$ldap_password/"\
  	  > /etc/proftpd/ldap.conf
 done