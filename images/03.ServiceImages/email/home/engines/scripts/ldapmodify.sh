#/bin/bash

. /home/engines/functions/ldap_support_functions.sh

sudo /home/engines/scripts/sudo/_ldapmodify.sh $* &> $LDAP_OUTF
result=$?

process_ldap_result
