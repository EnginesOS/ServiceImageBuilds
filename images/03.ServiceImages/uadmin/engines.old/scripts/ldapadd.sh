#!/bin/sh


. /home/engines/functions/ldap/support_functions.sh

sudo /home/engines/scripts/sudo/_ldapadd.sh $* 2>&1 > $LDAP_OUTF
result=$?

process_ldap_result


