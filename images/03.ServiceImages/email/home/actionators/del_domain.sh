#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env
. /home/engines/functions/ldap_support_functions.sh

if test -z $domain_name
 then
  echo '{"error":"Missing $domain_name"}'
  exit 127
fi

dn_tmpl=`cat /home/engines/templates/email/del_domain.ldif`
dn=`eval echo $dn_tmp. `
/home/engines/scripts/ldapdelete.sh $dn &> $LDAP_OUTF
result=$?

process_ldap_result
