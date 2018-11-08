#!/bin/bash
 /home/engines/functions/params_to_env.sh
params_to_env

 if test -z $cn
  then
   echo cn cant be nill
   exit -1
  fi 
  

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
. $SCRIPTPATH/set_ou_dn.sh

  
cat $SCRIPTPATH/add_ou.ldif | while read LINE
      do
        eval echo "$LINE" >> $LDIF_FILE
      done
   cat $LDIF_FILE | /home/engines/scripts/ldap/ldapmodify.sh  
   rm  $LDIF_FILE
  done
  