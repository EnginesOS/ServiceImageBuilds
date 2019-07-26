#!/bin/bash
n=0
sleep 5
while test $n -ne 5
 do
   if ! test -f /home/engines/run/slapd.pid
    then 
     sleep 5
   else
     break
   fi
  n=`expr $n + 1`
done
 
export KRB5_KTNAME=/etc/krb5kdc/keys/ldap.keytab
 
 sleep 5

password=`dd if=/dev/urandom count=16 bs=1  | od -h | awk '{ print $2$3$4$5$6$7$8}'`
echo -n $password > /var/lib/ldap/.tok
#shapass=`echo -n $password  | openssl dgst -sha1 -binary | openssl enc -base64`
salt=`head -c 40 /dev/random | base64 | sed -e 's/+/./g' |  cut -b 10-25`
shapass=`mkpasswd --rounds 500000 -m sha-512 --salt $salt $password`
cat /home/engines/templates/ldap/first_run/init_pre_password.ldif >  /tmp/init.ldif
echo olcRootPW: {CRYPT}$shapass >> /tmp/init.ldif
#| sed "s/PASSWORD/$shapass/" > /tmp/init.ldif
cat /home/engines/templates/ldap/first_run/init_post_password.ldif >>  /tmp/init.ldif
echo Setup config
ldapmodify -Y EXTERNAL -H ldapi:/// -f /tmp/init.ldif
exit_code=$?
#rm  /tmp/init.ldif
if  test $exit_code -ne 0
 then
  echo Failed init.ldif
  exit $exit_code
fi  

echo  add modules
ldapmodify -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/first_run/modules.ldif
exit_code=$?
if  test $exit_code -ne 0
 then
  echo Failed modules.ldif
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

echo Schema for password policy
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/ppolicy.ldif
exit_code=$?
if  test $exit_code -ne 0
 then
  echo Failed /etc/ldap/schema/ppolicy.ldif
  exit $exit_code
fi  

echo Schema for samba accounts integration
d=`pwd`
cd /home/engines/templates/ldap/first_run/

wget https://raw.githubusercontent.com/zentyal/samba/master/examples/LDAP/samba.ldif
cd $d

 ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/first_run/samba.ldif
 
echo Schema for postfix virtual accounts integration
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/first_run/postfix.ldif
exit_code=$?
if  test $exit_code -ne 0
 then
  echo Failed postfix.ldif
  exit $exit_code
fi  
echo Schema for sshkey
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/engines/templates/ldap/first_run/sshkey.ldif
exit_code=$?
if  test $exit_code -ne 0
 then
  echo Failed sshkey.ldif
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
 