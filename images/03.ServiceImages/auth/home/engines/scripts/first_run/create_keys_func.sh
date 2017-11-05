#!/bin/sh

gen_service_key()
{
echo addprinc -randkey host/$service.engines.internal@ENGINES.INTERNAL | kadmin.local 
mkdir -p /etc/krb5kdc/services/$service 
   
echo ktadd -k /etc/krb5kdc/services/$service/$service.keytab host/$service.engines.internal@ENGINES.INTERNAL | kadmin.local 

}

create_keys()
{

for service in `cat /home/engines/scripts/first_run/key_list`
 do
  gen_service_key
 done 
 
echo addprinc -randkey ldap/ldap.engines.internal@ENGINES.INTERNAL | kadmin.local
mkdir /etc/krb5kdc/services/ldap
echo ktadd -k /etc/krb5kdc/services/ldap/ldap.keytab ldap/ldap.engines.internal@ENGINES.INTERNAL | kadmin.local
 
echo addprinc -randkey uadmin/admin@ENGINES.INTERNAL | kadmin.local
echo ktadd -k /etc/krb5kdc/services/uadmin/uadmin_kadmin.keytab uadmin/admin@ENGINES.INTERNAL | kadmin.local
 
}