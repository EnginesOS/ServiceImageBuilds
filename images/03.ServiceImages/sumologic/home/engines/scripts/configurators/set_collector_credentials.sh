#!/bin/bash

cat - >/home/engines/scripts/configurators/saved/credentials
. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/credentials
parms_to_file_and_env
exit 0
