#!/bin/bash

if test -f /home/configurators/saved/default_domain
 then
	cat /home/configurators/saved/default_domain
else
	echo '{"default_domain":"Not Set"}'
fi
exit 0