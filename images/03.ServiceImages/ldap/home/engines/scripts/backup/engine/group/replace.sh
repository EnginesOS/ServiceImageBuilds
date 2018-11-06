#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

uids=`cat - |grep memberUid`
group_name=${cn}


 if test -z $group_name
  then
   echo group_name cant be nill
   exit -1
  fi 

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
. $SCRIPTPATH/set_group_dn.sh

 members=`ldapsearch -D ${ldap_dn} -w ${ldap_password} -h ${LDAP_HOST} -b ${group_dn} |grep -i memberuid`
 for member in $members
  do
   uid=`echo $member |cut -f2 -d:`
     cat $SCRIPTPATH/rm_user_from_group.ldif | while read LINE
      do
        eval echo "$LINE" >> $LDIF_FILE
      done
   cat $LDIF_FILE | /home/engines/scripts/ldap/ldapmodify.sh  
   rm  $LDIF_FILE
  done
  
for uid in $uids
 do
  cat $SCRIPTPATH/add_user_to_group.ldif | while read LINE
   do
     eval echo "$LINE" >> $LDIF_FILE
   done
 cat $LDIF_FILE | /home/engines/scripts/ldap/ldapmodify.sh  
 rm  $LDIF_FILE
done

