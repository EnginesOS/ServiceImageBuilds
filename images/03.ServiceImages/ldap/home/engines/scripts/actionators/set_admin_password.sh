#!/bin/bash


required_values="new_password"
check_required_values

. /home/engines/functions/ldap/support_functions.sh

echo -n "$new_password" | sudo -n /home/engines/scripts/actionators/_set_admin_password.sh  >$LDAP_OUTF
result=$?

process_ldap_result