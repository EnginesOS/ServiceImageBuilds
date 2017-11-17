#!/bin/sh
. /home/engines/functions/ldap/support_functions.sh
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="password"
check_required_values

sudo -n /home/engines/scripts/actionators/_set_admin_password.sh "$password" >$LDAP_OUTF
result=$?

process_ldap_result