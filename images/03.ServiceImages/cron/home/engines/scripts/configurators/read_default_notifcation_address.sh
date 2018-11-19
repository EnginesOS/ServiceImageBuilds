#!/bin/sh
if test -f /home/engines/scripts/configurators/saved/default_notifcation_address
 then
  . /home/engines/scripts/configurators/saved/default_notifcation_address
  echo '{"default_notifcation_address":"'$default_notifcation_address'"}'
else
  echo '{"default_notifcation_address":"Not Set"}'
fi

exit 0