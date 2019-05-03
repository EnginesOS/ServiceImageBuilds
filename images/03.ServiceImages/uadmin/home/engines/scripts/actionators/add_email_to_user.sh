#!/bin/sh

 . /home/engines/functions/checks.sh
 
required_values="email_address uid"
check_required_values 

. /home/engines/functions/ldap/support_functions.sh

dn=`/home/engines/scripts/ldap/get_dn.sh  ou=People,dc=engines,dc=internal uid=$uid`


cat /home/engines/templates/add_email_to_user.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done


/home/engines/scripts/ldap/ldapmodify.sh -f $LDIF_FILE 
