#!/bin/sh
. /home/engines/functions/ldap_support_functions.sh
. /home/engines/functions/params_to_env.sh
parms_to_env

sudo -n /home/actionators/_set_admin_password.sh "$password" >$LDAP_OUTF
result=$?

process_ldap_result