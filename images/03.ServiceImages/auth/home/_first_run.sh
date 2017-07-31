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

kdb5_ldap_util -D  cn=admin,dc=engines,dc=internal create \
	-subtrees dc=engines,dc=internal -r ENGINES.INTERNAL -s -H ldap://ldap.engines.internal

	

