#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/default_site_url
	then
		cat /home/engines/scripts/configurators/saved/default_site_url
	else
	echo '{"default_site_url":"Not Saved"}'

fi

exit 0