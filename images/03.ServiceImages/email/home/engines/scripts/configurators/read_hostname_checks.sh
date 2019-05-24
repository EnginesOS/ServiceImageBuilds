#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/hostname_checks
 then
  s=true
else
 s=false
fi

echo '{"hostname_checks":"'$s'"}'

exit 0
