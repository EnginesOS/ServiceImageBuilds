#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
required_values="uid"
check_required_values 
. /home/engines/functions/ldap/support_functions.sh

r=`cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh` 