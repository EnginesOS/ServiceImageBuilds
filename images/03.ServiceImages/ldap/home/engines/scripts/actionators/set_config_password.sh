#!/bin/sh
 . /home/engines/functions/checks.sh

required_values="new_password"
check_required_values

. /home/engines/functions/ldap/support_functions.sh

echo -n "$new_password" | sudo -n /home/engines/scripts/actionators/sudo/_set_config_password.sh  >$LDAP_OUTF
result=$?

process_ldap_result