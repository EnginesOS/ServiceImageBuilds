#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z $group_name
 then 
  echo "Missing Group name"
  exit 127
 fi
 
 . /home/engines/functions/ldap_support_functions.sh

gidNumber=`/home/engines/scripts/next_gid.sh`
cat /home/templates/add_email_group.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done




cat $LDIF_FILE | /home/engines/scripts/ldapadd.sh 