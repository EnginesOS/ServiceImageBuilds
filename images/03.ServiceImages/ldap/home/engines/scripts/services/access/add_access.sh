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



if test $read_access = all
 then
  read_acl="  by * read"
elif test $read_access = private
 then
  read_acl="  by * none"
elif test $read_access = authenticated
 then  
  read_acl="  by * authenticated"
else
   	read_acl=" by dn="$read_access"
fi

if test $write_access = all
 then
  write_acl="  by * write"
elif test $write_access = private
 then
  write_acl=""
elif test $write_access = authenticated
 then  
  write_acl="  by authenticated write" 
else
   	write_acl="  by dn="$write_access""
fi


LDIF_FILE=`mktemp`
LDAP_OUTF=`mktemp`

 cat /home/engines/templates/ldap/services/add_access.ldif | while read LINE
   do
     eval echo $LINE >> $LDIF_FILE
   done

echo "  by dn=cn=admin,ou=People,ou=Engines,dc=engines,dc=internal manage"  >> $LDIF_FILE
echo "  by dn=cn=uadmin,ou=hosts,ou=Engines,dc=engines,dc=internal manage"  >> $LDIF_FILE
it ! test -z $write_acl
 then
	echo  $write_acl >> $LDIF_FILE
fi
echo $read_acl >> $LDIF_FILE
 cat $LDIF_FILE |sudo /home/engines/scripts/ldap/sudo/_ldapmodify.sh  &> $LDAP_OUTF
 cp $LDIF_FILE /tmp/access
 rm $LDIF_FILE
 