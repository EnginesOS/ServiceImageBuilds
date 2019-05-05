#!/bin/sh
 . /home/engines/functions/checks.sh
required_values="uid"
check_required_values 
. /home/engines/functions/ldap/support_functions.sh

r=`/home/engines/scripts/ldap/ldapadd.sh -f $LDIF_FILE ` 