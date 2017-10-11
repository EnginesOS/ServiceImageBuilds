#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z $domain_name
 then
  echo '{"error":"Missing $domain_name"}'
  exit 127
fi
dn_tmpl=`cat  /home/actionators/tmpls/del_domain.ldif`
dn=`eval echo $dn_tmp. `
/home/engines/scripts/ldapdelete.sh $dn
  
  
