#!/bin/bash
if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env>/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env
#FIXME make engines.internal settable

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
	/home/rebuild_crontab.sh
fi

echo "Success"
exit 0

