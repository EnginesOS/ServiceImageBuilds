#/bin/bash

. /home/engines/functions/ldap/support_functions.sh

sudo /home/engines/scripts/sudo/_ldapadd.sh $* &> $LDAP_OUTF
result=$?

process_ldap_result


