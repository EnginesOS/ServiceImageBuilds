#!/bin/bash
n=0
sleep 5
while test $n -ne 5
 do
   if ! test -f /var/run/slapd/slapd.pid
    then 
     sleep 5
   else
     break
   fi
  n=`expr $n + 1`
done
 
export KRB5_KTNAME=/etc/krb5kdc/keys/ldap.keytab
 
 sleep 5

echo Create dc=engines,dc=internal
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/first_run/init.ldif
exit_code=$?
if  test $exit_code -ne 0
 then
  echo Failed init.ldif
  exit $exit_code
fi  

echo  oid for nextid attr type
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/first_run/uidNext.ldif
exit_code=$?
if  test $exit_code -ne 0
 then
  echo Failed uidNext.ldif
  exit $exit_code
fi  

echo Schema for postfix virtual accounts integration
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/first_run/postfix.ldif
exit_code=$?
if  test $exit_code -ne 0
 then
  echo Failed postfix.ldif
  exit $exit_code
fi  

echo tree root ou 
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/first_run/root_ou.ldif
exit_code=$?
if test $exit_code -ne 0
 then
  echo Failed root_ou.ldif
  exit $exit_code
fi  

echo setup sasl params and user mapping to kererbos principles
ldapmodify -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/first_run/auth.ldif
exit_code=$?
if test $exit_code -ne 0
 then
  echo Failed auth.ldif
  exit $exit_code
fi  

mv /usr/lib/sasl2/sasl2_slapd.conf /usr/lib/sasl2/slapd.conf

kinit -kt /etc/krb5kdc/keys/ldap.keytab 
ldapadd -h ldap -f /home/engines/templates/ldap/first_run/initial_ous.ldif
ldapadd -h ldap -f /home/engines/templates/ldap/first_run/group_ous.ldif
ldapadd -h ldap -f /home/engines/templates/ldap/first_run/add_admin.ldif
exit_code=$?
if test $exit_code -ne 0
 then
  echo Failed initial_ous.ldif
  kdestroy
  exit $exit_code
fi  
kdestroy

 if test $exit_code -eq 0
    then
     touch /home/engines/run/flags/init_ous_configured
   fi
 exit $exit_code
 