#!/bin/bash

#Create dc=engines,dc=internal
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/tmpls/init.ldif

#oid for nextid attr type
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/tmpls/uidNext.ldif

#Schema for postfix virtual accounts integration
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/tmpls/postfix.ldif

#tree root ou 
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/tmpls/root_ou.ldif

#setup sasl params and user mapping to kererbos principles
ldapmodify -Y EXTERNAL -H ldapi:/// -f /home/tmpls/auth.ldif

mv /usr/lib/sasl2/sasl2_slapd.conf /usr/lib/sasl2/slapd.conf

kinit -kt /etc/krb5kdc/keys/ldap.keytab 
ldapadd -h ldap -f /home/tmpls/initial_ous.ldif
kdestroy