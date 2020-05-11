#/bin/bash

. /home/engines/functions/ldap/support_functions.sh
sudo -n /home/engines/scripts/ldap/sudo/_ldapmodify.sh $* &> /tmp/ldap.mod.out
result=$?

process_ldap_result




