#!/bin/sh


. /home/engines/functions/ldap/support_functions.sh

cat - | sudo /home/engines/scripts/ldap/sudo/_ldapadd.sh $*  2>&1 > $LDAP_OUTF
result=$?

process_ldap_result

exit $result
