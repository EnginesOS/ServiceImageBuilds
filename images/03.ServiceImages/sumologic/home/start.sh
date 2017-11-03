#!/bin/bash
#wait for configurators
sleep 10
rm  -f /home/engines/run/flags/startup_complete
if test -f /home/engines/scripts/configurators/saved/credentials
 then
 	 cat /home/engines/scripts/configurators/saved/credentials | /home/engines/bin/json_to_env >/tmp/.env
 	. /tmp/.env
 	rm -f /home/engines/run/missing_configuration
 	echo Configured
 else
 	touch /home/engines/run/missing_configuration
 	echo "Not Configured"
 	sleep 500
 	exit
fi

PID_FILE=opt/SumoCollector/collector.pid

export PID_FILE
. /home/engines/functions/trap.sh


echo Access ID $access_id 

collector_name=${collector_name:=collector_container}
sources_json=${SUMO_SOURCES_JSON:=/home/sumo-sources.json}

if [ -z "$access_id" ] || [ -z "$access_key" ]; then
    echo "FATAL: Please provide credentials, either via the SUMO_ACCESS_ID and SUMO_ACCESS_KEY environment variables,"
    echo "       or as the first two command line arguments!"
    sleep 500
    exit -1
fi

if [ ! -e $sources_json ]; then
    echo "FATAL: Unable to find $sources_json - please make sure you include it in your image!"
    sleep 500
    exit -1
fi

sudo -n /opt/SumoCollector/collector console -- -t -i $access_id -k $access_key -n $collector_name -s $sources_json &

startup_complete

wait
exit_code=$?

shutdown_complete

