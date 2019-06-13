#!/bin/sh
if test -f /home/engines/scripts/configurators/saved/default_notifcation_address
 then
  addr=`cat /home/engines/scripts/configurators/saved/default_notifcation_address`
else
 addr=Not Set
fi

echo '{"notification_address":"'$addr'"}'

exit 0
