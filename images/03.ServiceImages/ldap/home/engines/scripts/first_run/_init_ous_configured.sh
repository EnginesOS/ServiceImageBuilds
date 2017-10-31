#!/bin/bash

#Create dc=engines,dc=internal
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/init.ldif
exit_code=$?
if  test $exit_code -ne 0
 then
  echo Failed init.ldif
  exit $exit_code
fi  

#oid for nextid attr type
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/uidNext.ldif
exit_code=$?
if  test $exit_code -ne 0
 then
  echo Failed uidNext.ldif
  exit $exit_code
fi  

#Schema for postfix virtual accounts integration
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/postfix.ldif
exit_code=$?
if  test $exit_code -ne 0
 then
  echo Failed postfix.ldif
  exit $exit_code
fi  

#tree root ou 
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/root_ou.ldif
exit_code=$?
if test $exit_code -ne 0
 then
  echo Failed root_ou.ldif
  exit $exit_code
fi  

#setup sasl params and user mapping to kererbos principles
ldapmodify -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/auth.ldif
exit_code=$?
if test $exit_code -ne 0
 then
  echo Failed auth.ldif
  exit $exit_code
fi  

mv /usr/lib/sasl2/sasl2_slapd.conf /usr/lib/sasl2/slapd.conf

kinit -kt /etc/krb5kdc/keys/ldap.keytab 
ldapadd -h ldap -f /home/engines/templates/ldap/initial_ous.ldif
ldapadd -h ldap -f /home/engines/templates/ldap/group_ous.ldif
exit_code=$?
if test $exit_code -ne 0
 then
  echo Failed initial_ous.ldif
  kdestroy
  exit $exit_code
fi  
kdestroy
 exit $exit_code