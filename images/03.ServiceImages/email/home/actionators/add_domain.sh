#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

if test -z $domain_name
 then
  echo '{"error":"Missing $domain_name"}'
  exit 127
fi

. /home/engines/functions/ldap_support_functions.sh



cat /home/actionators/tmpls/add_domain.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done

cat $LDIF_FILE /home/engines/scripts/ldapadd.sh &> $LDAP_OUTF
result=$?

process_ldap_result

rm $LDIF_FILE  $LDAP_OUTF