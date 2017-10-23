#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

if test -z $email_group
 then 
  echo "Missing Group name"
  exit 127
 fi
 
 . /home/engines/functions/ldap/support_functions.sh

gidNumber=`/home/engines/scripts/ldap/next_gid.sh`
cat /home/engines/templates/add_email_group.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done




cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh 