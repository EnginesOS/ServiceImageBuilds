#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

if test -z "${parent_engine}"
 then
echo Error:Missing parent_engine
      exit -1
fi

if test -z ${title}
 then
	echo Error:missing title
    exit -1
fi  

if test -f /home/cron/entries/${parent_engine}/$title
 then
	rm /home/cron/entries/${parent_engine}/$title
	/home/engines/scripts/cron/rebuild_crontab.sh
fi

echo "Success"
exit 0

