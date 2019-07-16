#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/notifications_email
then
    . /home/engines/scripts/configurators/saved/notifications_email
     echo '{"notifications_email":"'$notifications_email'",
     		"postmaster_email":"'$postmaster_email'",
     		"hostmaster_email":"'$hostmaster_email'",
     		"webmaster_email":"'$webmaster_email'"}'
else
	echo '{"notifications_email":"Not Set"}'
fi
exit 0