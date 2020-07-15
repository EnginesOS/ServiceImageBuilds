#!/bin/sh
dn=$1

if test $container_type = app
 then
 id=$parent_engine/host
elif test $container_type = service
 then
  id=$parent_engine/service
elif test $container_type = system_service
 then
  id=$parent_engine/service
else
 echo incorrect container type $container_type
 exit 127
fi  

if test -z $private
 then
  private='*'
fi  
LDIF_FILE=`mktemp`
 cat /home/engines/templates/ldap/services/rm_access.ldif | while read LINE
   do
     eval echo "$LINE" >> $LDIF_FILE
   done
   
echo "" >> $LDIF_FILE
echo "" >> $LDIF_FILE

LDAP_OUTF=`mktemp`
cat $LDIF_FILE |sudo /home/engines/scripts/ldap/sudo/_ldapmodify.sh  2>&1 > $LDAP_OUTF
if test $? -eq 0
 then
  rm  $LDAP_OUTF $LDIF_FILE
 else
  cat  LDAP_OUTF
fi 
if test -z $group_membership
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

/home/engines/scripts/services/access/rm_group_membership.sh

