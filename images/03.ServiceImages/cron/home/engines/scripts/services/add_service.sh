#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="cron_job when title parent_engine container_type"
check_required_values


mkdir -p /home/cron/entries/${parent_engine}/

if test  ${container_type} = container
 then
 	container_type=engine
fi

if test $action_type = "web"
 then
    cmd="curl http://${parent_engine}.engines.internal:8000$cron_job  -o /tmp/out"
elif test $action_type = "command"
 then
 	cmd="curl https://172.17.0.1:2380/v0/cron/engine/${parent_engine}/$title/run"
elif test $action_type = "schedule"
 then
    cmd="curl https://172.17.0.1:2380/v0/schedule/${container_type}/${parent_engine}/$cron_job"
elif test $action_type = "action"
 then
    cmd="curl https://172.17.0.1:2380/v0/schedule/${container_type}/${parent_engine}/$title/run"
fi

echo "$when $cmd " > /home/cron/entries/${parent_engine}/$title

/home/engines/scripts/engine/rebuild_crontab.sh

echo "Success"
exit 0
