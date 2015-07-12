#!/bin/sh



if test -f /home/configurators/saved/system_backup
	then
		cat /home/configurators/saved/system_backup
	else
		echo "Not Set"
fi