#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/notifications_email
then
	cat /home/engines/scripts/configurators/saved/notifications_email
else
	echo '{"notifications_email":"Not Set"}'
fi
exit 0