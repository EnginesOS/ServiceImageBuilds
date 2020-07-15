#!/bin/sh
. /home/engines/functions/ldap/support_functions.sh
LDIF_FILE=`mktemp`
sha_pass=`slappasswd -h {SHA} -s $ldap_password`
cat /home/engines/templates/ldap/services/add_host_entry.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done
echo "" >> $LDIF_FILE
echo "" >> $LDIF_FILE

cp $LDIF_FILE /tmp/create_account
cat $LDIF_FILE | sudo /home/engines/scripts/ldap/sudo/_ldapadd.sh $* 2>&1 > $LDAP_OUTF

if test -z $group_membership
 then
 exit 0
fi

if test $container_type = app
 then 
  root_ou=ou=Applications,ou=Groups,dc=engines,dc=internal
 elif test $container_type = service
  root_ou=ou=Services,ou=Groups,dc=engines,dc=internal
 else echo "invalid container_type"
  exit 2
 fi  
 
member_id=${parent_engine}
group_dn="$group_membership,$root_ou"
export $member_id $group_dn

/home/engines/scripts/services/access/add_group_membership.sh
