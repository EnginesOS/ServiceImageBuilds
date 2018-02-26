#!/bin/sh
dn=$1

if test ${container_type} = app
 then
 id=${parent_engine}/host
elif test $container_type =  service
 then
  id=${parent_engine}/service
elif test ${container_type} = system_service
 then
  id=${parent_engine}/service
else
 echo incorrect container type $container_type
 exit 127
fi  

id="cn=${parent_engine},ou=hosts,ou=engines,dc=engines,dc=internal"

if ! test -z $private
 then
  private='by none read'
 else
  private='by * read'
fi  

LDIF_FILE=`mktemp`
LDAP_OUTF=`mktemp`

 cat /home/engines/templates/ldap/services/add_access.ldif | while read LINE
   do
     eval echo $LINE >> $LDIF_FILE
   done
echo $private >> $LDIF_FILE
echo by dn=cn=admin,ou=People,ou=Engines,dc=engines,dc=internal manage  >> $LDIF_FILE
echo by dn="cn=uadmin,ou=hosts,ou=Engines,dc=engines,dc=internal" manage  >> $LDIF_FILE
 cat $LDIF_FILE |sudo /home/engines/scripts/ldap/sudo/_ldapmodify.sh  &> $LDAP_OUTF
 cp $LDIF_FILE /tmp/access
 rm $LDIF_FILE
 