#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z $domain_name
 then
  echo '{"error":"Missing $domain_name"}'
  exit 127
fi

rm /tmp/ldif
cat /home/actionators/tmpls/add_domain.ldif | while read LINE
do
 eval echo $LINE >> /tmp/ldif
done


cat /tmp/ldif | /home/engines/scripts/ldapadd.sh 




