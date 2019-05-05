#!/bin/sh

 . /home/engines/functions/checks.sh
 
required_values="uid email_address"
check_required_values 

dn=`/home/engines/scripts/ldap/get_dn.sh  ou=People,dc=engines,dc=internal uid=$uid`

. /home/engines/functions/ldap/support_functions.sh

cat /home/engines/templates/del_user_email.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done


/home/engines/scripts/ldap/ldapmodify.sh -f $LDIF_FILE 
