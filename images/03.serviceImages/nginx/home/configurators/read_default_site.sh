#!/bin/bash

if test -f /home/configurators/saved/default_site_url
	then
		cat /home/configurators/saved/default_site_url
	else
	echo '{"default_site_url":"Not Saved"}'

fi

exit 0