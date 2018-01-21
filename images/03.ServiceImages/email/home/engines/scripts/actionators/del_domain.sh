#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env
. /home/engines/functions/ldap/support_functions.sh

if test -z $domain_name
 then
  echo '{"error":"Missing $domain_name"}'
  exit 127
fi

dn_tmpl=`cat /home/engines/templates/ldap/del_domain.ldif`
dn=`eval echo $dn_tmpl `
/home/engines/scripts/ldap/ldapdelete.sh $dn &> $LDAP_OUTF
result=$?

process_ldap_result
