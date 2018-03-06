#!/bin/sh
if ! test -d  /etc/postfix/ldap
 then
	mkdir /etc/postfix/ldap
fi	
	

files="ldap-aliases.cf ldap-groups.cf ldap-virtual-domains.cf ldap-vmailbox.cf"

for file in files
 do
  cat /home/engines/templates/email/ldap/$file |\
  	 sed "s/LDAP_BIND_DN/$ldap_dn/"|\
  	  sed "s/LDAP_BIND_PW/$ldap_password/"\
  	  > /etc/postfix/ldap
 done