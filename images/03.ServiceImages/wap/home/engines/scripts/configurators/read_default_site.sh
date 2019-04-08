#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/default_site
	then
		default_site=`cat /home/engines/scripts/configurators/saved/default_site_url`
		echo '{"default_site":"'$default_site'"}'
	else
	echo '{"default_site":"Not Saved"}'

fi

exit 0