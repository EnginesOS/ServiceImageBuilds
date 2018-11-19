#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/notifications_email
then
	notifications_email=`cat /home/engines/scripts/configurators/saved/notifications_email`
	echo '{"notifications_email":"'$notifications_email'"}'
else
	echo '{"notifications_email":"Not Set"}'
fi
exit 0