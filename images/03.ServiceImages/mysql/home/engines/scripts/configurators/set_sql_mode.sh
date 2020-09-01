#!/bin/sh

 . /home/engines/functions/checks.sh
 required_values="sql_mode"
check_required_values
cd /home/engines/scripts/configurators/saved

echo -n $sql_mode > sql_mode

/home/engines/scripts/engine/build_config.sh

