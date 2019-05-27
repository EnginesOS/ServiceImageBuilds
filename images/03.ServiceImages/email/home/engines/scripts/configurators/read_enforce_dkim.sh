#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/enforce_dkim
 then
  s=true
else
 s=false
fi

echo '{"enforce_dkim":"'$s'"}'

exit 0
