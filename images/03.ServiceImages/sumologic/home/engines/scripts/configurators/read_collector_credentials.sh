#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/credentials
	then
		cat /home/engines/scripts/configurators/saved/credentials
	else
	echo '{"access_id":"Not set","access_key":"Not Saved"}'

fi

exit 0