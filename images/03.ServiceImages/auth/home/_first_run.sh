#!/bin/sh

ssh-keygen -y -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -y -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

if test -f /home/home_dir/.ssh/krb.pass
 then 
  pass=`cat /home/home_dir/.ssh/krb.pass`
else
  pass=`dd if=/dev/urandom count=12 bs=1  | od -h | awk '{ print $2$3$4$5$6}'`
  echo $pass > /home/home_dir/.ssh/krb.pass
  chmod og-rwx /home/home_dir/.ssh/krb.pass
fi

	
	
export pass 
expect /home/auth/kerobos_init.expect
expect /home/auth/kerobos_stash_key.expect
 

#
#
#

#kdb5_ldap_util -D  cn=admin,dc=engines,dc=internal create -subtrees dc=engines,dc=internal -r ENGINES.INTERNAL -s -H ldap://ldap.engines.internal
kdb5_ldap_util  -sf /etc/krb5kdc/ldap/service.keyfile  create -subtrees dc=engines,dc=internal -r ENGINES.INTERNAL -s -H ldap://ldap.engines.internal

#Password for "cn=admin,dc=engines,dc=internal": 
#Initializing database for realm 'ENGINES.INTERNAL'
#You will be prompted for the database Master Password.
#It is important that you NOT FORGET this password.
#Enter KDC database master key: 
#Re-enter KDC database master key to verify: 
#Enter DN of Kerberos container: cn=krbcontainer,dc=engines,dc=internal
 



	

