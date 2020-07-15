#!/bin/sh

. /home/engines/functions/ldap/support_functions.sh
sudo -n /home/engines/scripts/ldap/sudo/_ldapdelete.sh $* 2>&1 > /tmp/ldap.del.out
result=$?

process_ldap_result
exit $result