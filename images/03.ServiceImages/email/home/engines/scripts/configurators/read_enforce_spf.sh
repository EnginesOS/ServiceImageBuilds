#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/enforce_spf
 then
  s=true
else
 s=false
fi

echo '{"enforce_spf":"'$s'"}'

exit 0
