#!/bin/sh
backup_email=`cat /home/engines/scripts/configurators/saved/backup_email`

  echo '{"email_notification":"'$backup_email'"}'

exit 0

