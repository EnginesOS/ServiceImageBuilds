#!/bin/sh

 . /home/engines/functions/checks.sh
 
required_values="email_address email_group"
check_required_values 
 
. /home/engines/functions/ldap/support_functions.sh

cat /home/engines/templates/add_email_to_email_group.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done


cat $LDIF_FILE | /home/engines/scripts/ldap/ldapmodify.sh  