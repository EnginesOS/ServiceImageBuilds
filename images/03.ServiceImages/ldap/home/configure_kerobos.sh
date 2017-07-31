#!/bin/bash

mkdir -p /etc/krb5kdc/keys/ldap

gzip -d /usr/share/doc/krb5-kdc-ldap/kerberos.schema.gz
cp /usr/share/doc/krb5-kdc-ldap/kerberos.schema /etc/ldap/schema/

mkdir /tmp/ldif_output

slapcat -f /home/schema_convert.conf -F /tmp/ldif_output -n0 -s \
"cn={12}kerberos,cn=schema,cn=config" > /tmp/cn=kerberos.ldif

l=`wc -l /tmp/cn=kerberos.ldif |cut -f1 -d" "`
l=`expr $l - 8`
head -$l /tmp/cn=kerberos.ldif > /tmp/cn
l=`wc -l /tmp/cn |cut -f1 -d" "`
l=`expr $l - 3`
echo "
dn: cn=kerberos,cn=schema,cn=config
objectClass: olcSchemaConfig
cn: kerberos 
" >/tmp/cn=kerberos.ldif
tail -$l /tmp/cn >>/tmp/cn=kerberos.ldif
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /tmp/cn\=kerberos.ldif


kdb5_ldap_util -D  cn=admin,dc=engines,dc=internal stashsrvpw \
	-f /etc/krb5kdc/service.keyfile cn=admin,dc=engines,dc=internal
