#!/bin/sh


. /home/engines/functions/ldap/support_functions.sh
cat - |sudo -n /home/engines/scripts/ldap/sudo/_ldapmodify.sh $* 2>&1 > /tmp/ldap.mod.out
result=$?

process_ldap_result

exit $result


