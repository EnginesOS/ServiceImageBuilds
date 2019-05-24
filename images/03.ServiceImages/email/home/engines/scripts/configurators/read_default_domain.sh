#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/default_domain
	then
		default_domain=`cat /home/engines/scripts/configurators/saved/default_domain`
		echo '{"default_domain":"'$default_domain'"}'
	else
	#echo '{"default_domain":"Not Set"}'
	echo '{}'

fi
exit 0