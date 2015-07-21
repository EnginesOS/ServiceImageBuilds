#!/bin/bash


service_hash=`echo  "$1" | sed "/\*/s//STAR/g"`
. /home/engines/scripts/functions.sh

load_service_hash_to_environment

#FIXME make engines.internal settable

	if test -z ${cron_job}
	then
		echo Error:Missing cron_job
        exit -1
    fi
  	if test -z ${title}
	then
		echo Error:missing name
        exit -1
    fi  

if test -f /home/entries/${parent_engine}/$title
 then
	rm /home/cron/entries/${parent_engine}/$title
	/home/rebuild_crontab.sh
fi

echo "Success"
exit 0

