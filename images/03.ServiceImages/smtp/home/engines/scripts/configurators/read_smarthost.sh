#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/smarthost
then
	cat /home/engines/scripts/configurators/saved/smarthost
else
	echo '{"smarthost_hostname":"Not Set"}'
fi
exit 0