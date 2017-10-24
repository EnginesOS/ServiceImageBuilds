#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/backup_email_hash
 then
  cat /home/engines/scripts/configurators/saved/backup_email_hash
else
  echo '{"email_notification":"Not Set"}'
fi
exit 0

