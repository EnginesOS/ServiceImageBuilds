#!/bin/bash


service_hash=$1



 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env
#FIXME make engines.internal settable

	if test -z "${cron_job}"
	then
		echo Error:Missing cron_job
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
	/home/rebuild_crontab.sh
fi

echo "Success"
exit 0

