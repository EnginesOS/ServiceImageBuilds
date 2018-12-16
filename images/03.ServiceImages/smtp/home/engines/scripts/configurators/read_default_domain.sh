#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/domain
 then
    domain_name=`cat /home/engines/scripts/configurators/saved/domain`
	echo '{"default_domain":"'$domain_name'"}'
else
	echo '{"default_domain":"Not Set"}'
fi
exit 0