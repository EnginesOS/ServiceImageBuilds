#!/bin/sh
dn=$1

if test $container_type = app
 then
 id = $parent_engine/host
elif test $container_type =  service
 then
  id = $parent_engine/service
elif test $container_type = system_service
 then
  id = $parent_engine/service
else
 echo incorrect container type $container_type
 exit 127
fi  

if test -z $private
 then
  private='*'
fi  
 
 cat /home/engines/templates/ldap/services/rm_access.ldif | while read LINE
   do
     eval echo $LINE >> $LDIF_FILE
   done


 cat $LDIF_FILE |sudo /home/engines/scripts/ldap/sudo/_ldapmodify.sh  &> $LDAP_OUTF
 