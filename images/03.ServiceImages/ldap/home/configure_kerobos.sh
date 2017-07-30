#!/bin/bash


gzip -d /usr/share/doc/krb5-kdc-ldap/kerberos.schema.gz
cp /usr/share/doc/krb5-kdc-ldap/kerberos.schema /etc/ldap/schema/

mkdir /tmp/ldif_output

slapcat -f /home/schema_convert.conf -F /tmp/ldif_output -n0 -s \
"cn={12}kerberos,cn=schema,cn=config" > /tmp/cn=kerberos.ldif

l=`wc -l /tmp/cn=kerberos.ldif`
l=`expr $l - 7`
head -$l /tmp/cn=kerberos.ldif > /tmp/cn
cat /tmp/cn |sed 