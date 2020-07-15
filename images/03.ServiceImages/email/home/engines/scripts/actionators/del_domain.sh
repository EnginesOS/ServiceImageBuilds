#!/bin/sh

. /home/engines/functions/ldap/support_functions.sh

if test -z $domain_name
 then
  echo '{"error":"Missing $domain_name"}'
  exit 127
fi

dn_tmpl=`cat /home/engines/templates/ldap/del_domain.ldif`
dn=`eval echo $dn_tmpl `
/home/engines/scripts/ldap/ldapdelete.sh $dn 2>&1 > $LDAP_OUTF
result=$?

process_ldap_result
