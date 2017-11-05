#!/bin/bash

function gen_service_key {
echo addprinc -randkey host/$service.engines.internal@ENGINES.INTERNAL | kadmin.local 
mkdir -p /etc/krb5kdc/services/$service 
   
echo ktadd -k /etc/krb5kdc/services/$service/$service.keytab host/$service.engines.internal@ENGINES.INTERNAL | kadmin.local 

}



if test -f /home/home_dir/.ssh/krb.pass
 then 
  pass=`cat /home/home_dir/.ssh/krb.pass`
else
  pass=`dd if=/dev/urandom count=12 bs=1  | od -h | awk '{ print $2$3$4$5$6}'`
  echo $pass > /home/home_dir/.ssh/krb.pass
  chmod og-rwx /home/home_dir/.ssh/krb.pass
fi

	
export pass 
expect -d /home/engines/scripts/first_run/kerobos_init.expect
unset pass
/home/engines/scripts/startup/_start.sh 

for service in `cat /home/engines/scripts/first_run/key_list`
 do
  gen_service_key
 done 
 
echo addprinc -randkey ldap/ldap.engines.internal@ENGINES.INTERNAL | kadmin.local
mkdir /etc/krb5kdc/services/ldap
echo ktadd -k /etc/krb5kdc/services/ldap/ldap.keytab ldap/ldap.engines.internal@ENGINES.INTERNAL | kadmin.local
 
echo addprinc -randkey uadmin/admin@ENGINES.INTERNAL | kadmin.local
echo ktadd -k /etc/krb5kdc/services/uadmin/uadmin_kadmin.keytab uadmin/admin@ENGINES.INTERNAL | kadmin.local
 

wait $pid
exit_code=$?
 