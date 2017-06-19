#!/bin/bash

cat - >/home/configurators/saved/credentials
. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/configurators/saved/credentials
parms_to_file_and_env
exit 0
