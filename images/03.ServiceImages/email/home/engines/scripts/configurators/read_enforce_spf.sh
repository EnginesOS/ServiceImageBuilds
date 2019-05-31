#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/enforce_spf
 then
  s=true
  action=`cat /home/engines/scripts/configurators/saved/enforce_spf_action`
else
 s=false
fi

echo '{"enforce_spf":"'$s'","action":"'$action'"}'

exit 0
