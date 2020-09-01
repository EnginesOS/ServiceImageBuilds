#!/bin/sh

 . /home/engines/functions/checks.sh
 required_values="event_scheduler"
check_required_values
cd /home/engines/scripts/configurators/saved

echo -n $event_scheduler > event_scheduler

/home/engines/scripts/engine/build_config.sh
