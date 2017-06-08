#!/bin/bash


if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env>/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env
#FIXME make engines.internal settable

	if test -z "${cron_job}" 
	then
		echo Error:Missing cron_job
        exit -1
    fi
    if test -z "${when}"
	then
		echo Error:Missing when
        exit -1
    fi
  	if test -z ${title}
	then
		echo Error:missing title
        exit -1
    fi  
    	if test -z ${parent_engine}
	then
		echo Error:missing parent_engine
        exit -1
    fi  
    
rm  /home/cron/entries/${parent_engine}/$title



if test $action_type = "web"
	then
		cmd="curl http://${parent_engine}.engines.internal:8000$cron_job  -o /tmp/out"
	elif test $action_type = "command"
	 then
		cmd="curl http://172.17.0.1:2380/v0/cron/engine/${parent_engine}/$title/run"
     elif test $action_type = "schedule"
      then
       cmd="curl http://172.17.0.1:2380/v0/schedule/${container_type}/${parent_engine}/$cron_job"
     elif test $action_type = "action"
      then
       cmd="curl http://172.17.0.1:2380/v0/schedule/${container_type}/${parent_engine}/$title/run"
	fi

echo "$when $cmd " > /home/cron/entries/${parent_engine}/$title

/home/rebuild_crontab.sh

echo "Success"
exit 0
