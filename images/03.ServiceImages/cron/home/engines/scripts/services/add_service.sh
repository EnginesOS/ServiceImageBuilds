#!/bin/sh


 . /home/engines/functions/checks.sh
required_values="cron_job when title parent_engine container_type"
check_required_values


mkdir -p /home/cron/entries/${parent_engine}/$title

if test  ${container_type} = app
 then
 	container_type=engine
fi

echo -n $container_type > /home/cron/entries/${parent_engine}/$title/container_type
echo -n $action_type > /home/cron/entries/${parent_engine}/$title/action_type
echo -n $notification_address > /home/cron/entries/${parent_engine}/$title/notification_address
echo -n "$when" > /home/cron/entries/${parent_engine}/$title/when

if test $action_type = "web"
 then
    cmd="curl http://${parent_engine}.engines.internal:8000$cron_job"
elif test $action_type = "command"
 then
 	cmd="curl -k https://172.17.0.1:2380/v0/cron/engine/${parent_engine}/$title/run"
elif test $action_type = "schedule"
 then
    cmd="curl -k  https://172.17.0.1:2380/v0/schedule/${container_type}/${parent_engine}/$cron_job"
elif test $action_type = "action"
 then
    cmd="curl -k https://172.17.0.1:2380/v0/schedule/${container_type}/${parent_engine}/$title/run"
fi

echo -n "$cmd " > /home/cron/entries/${parent_engine}/$title/cmd
echo -n "$title" > /home/cron/entries/${parent_engine}/$title/title

/home/engines/scripts/engine/rebuild_crontab.sh

echo "Success"
exit 0
