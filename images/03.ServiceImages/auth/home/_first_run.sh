#!/bin/bash

function gen_service_key {
echo addprinc -randkey host/$service.engines.internal@ENGINES.INTERNAL | kadmin.local 
mkdir /etc/krb5kdc/$service 
echo ktadd -k /etc/krb5kdc/$service/$service.keytab host/$service.engines.internal@ENGINES.INTERNAL | kadmin.local 

}

#ssh-keygen -y -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
#ssh-keygen -y -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

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
#expect /home/auth/kerobos_stash_key.expect
 

for service in ldap ftp imap email postfix
 do
  gen_service_key
 done 
 
echo addprinc -randkey ldap/ldap.engines.internal@ENGINES.INTERNAL | kadmin.local

echo  ktadd -k /etc/krb5kdc/ldap/ldap.keytab ldap/ldap.engines.internal@ENGINES.INTERNAL | kadmin.local
 
 