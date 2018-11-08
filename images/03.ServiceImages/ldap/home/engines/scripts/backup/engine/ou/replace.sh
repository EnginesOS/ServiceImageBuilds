#!/bin/bash
 /home/engines/functions/params_to_env.sh
params_to_env



SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
. $SCRIPTPATH/set_ou_dn.sh
 if test -z $ou_dn
  then
   echo ou_dn cant be nill
   exit -1
  fi 
  

/home/engines/scripts/ldap/ldapdelete.sh "$ou_dn"

 cat $SCRIPTPATH/add_ou.ldif | while read LINE
      do
        eval echo "$LINE" >> $LDIF_FILE
      done
   cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh  
   rm  $LDIF_FILE
  done
  

