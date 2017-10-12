#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env
if test -z $email_address
 then
  echo "Missing email_address"
  exit 127
  fi
 if test -z  $email_group
 then
  echo "Missing email_group"
  exit 127
  fi
 
. /home/engines/functions/ldap_support_functions.sh

cat /home/templates/add_email_to_email_group.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done

cp 
cat $LDIF_FILE | /home/engines/scripts/ldapmodify.sh  