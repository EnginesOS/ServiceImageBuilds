#!/bin/sh

 . /home/engines/functions/checks.sh
 
required_values="uid group_name"
check_required_values 

. /home/engines/functions/ldap/support_functions.sh

cat /home/engines/templates/rm_user_from_group.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done


/home/engines/scripts/ldap/ldapmodify.sh -f $LDIF_FILE 