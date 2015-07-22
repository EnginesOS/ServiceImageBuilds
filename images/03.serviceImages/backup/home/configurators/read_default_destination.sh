#!/bin/sh

if test -f /home/configurators/saved/default_destination
	then
		cat /home/configurators/saved/default_destination
	else
		echo  ":default_destination=Not Set:"
fi

exit 0