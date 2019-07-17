#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/backup_email
 then
   . /home/engines/scripts/configurators/saved/backup_email
fi   

echo '{"backup_reports_email":"'$backup_reports_email'"}'

exit 0

