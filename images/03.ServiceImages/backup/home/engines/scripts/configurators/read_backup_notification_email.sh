#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/backup_email_hash
 then
  cat /home/engines/scripts/configurators/saved/backup_email_hash
else
  echo '{"email notification":"Not Set"}'
fi
exit 0

