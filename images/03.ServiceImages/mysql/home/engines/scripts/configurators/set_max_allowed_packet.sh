#!/bin/sh

 . /home/engines/functions/checks.sh
 required_values="max_allowed_packet"
check_required_values
cd /home/engines/scripts/configurators/saved

echo -n $max_allowed_packet > max_allowed_packet

/home/engines/scripts/engine/build_config.sh
