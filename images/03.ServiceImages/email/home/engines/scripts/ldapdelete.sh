#/bin/bash


. /home/engines/functions/ldap_support_functions.sh

sudo /home/engines/scripts/sudo/_ldapdelete.sh $* &> /tmp/ldap.out
result=$?

process_ldap_result

