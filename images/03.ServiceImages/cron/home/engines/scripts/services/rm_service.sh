#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="title parent_engine "
check_required_values


if test -f /home/cron/entries/${parent_engine}/$title
 then
	rm /home/cron/entries/${parent_engine}/$title
	/home/engines/scripts/engine/rebuild_crontab.sh
fi

echo "Success"
exit 0

