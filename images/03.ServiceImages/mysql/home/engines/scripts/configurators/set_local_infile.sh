#!/bin/sh

 . /home/engines/functions/checks.sh
 required_values="local_infile"
check_required_values
cd /home/engines/scripts/configurators/saved

echo -n $local_infile > local_infile

/home/engines/scripts/engine/build_config.sh
