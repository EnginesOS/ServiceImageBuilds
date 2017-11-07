#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/default_domain
	then
		cat /home/engines/scripts/configurators/saved/default_domain
	else
	#echo '{"default_domain":"Not Set"}'
	echo '{}'

fi
exit 0