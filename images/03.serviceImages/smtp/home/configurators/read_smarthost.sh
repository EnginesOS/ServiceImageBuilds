#!/bin/sh

if test -f /home/configurators/saved/smarthost
then
	cat /home/configurators/saved/smarthost
else
	echo ":smarthost_hostname=Not Set:"
fi
exit 0