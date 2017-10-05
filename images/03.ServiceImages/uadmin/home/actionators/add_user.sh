#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env
rm /tmp/ldif
cat /home/templates/add_user.ldif | while read LINE
do
 eval echo $LINE >> /tmp/ldif
done

ldapmodify -h ldap /home/templates/incre_uid.ldif

uidnumber=`ldapsearch -h ldap -b "cn=uidNext,dc=engines,dc=internal" -LLL uidNumber |grep uidNumber |cut -f2.-d:`

echo uidnumber:$uidnumber >> /tmp/ldif

cat /tmp/ldif | /home/engines/scripts/ldapadd.sh -h ldap 