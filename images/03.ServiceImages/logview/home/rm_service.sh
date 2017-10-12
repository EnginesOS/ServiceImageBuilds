#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env


rm /home/saved/$parent_engine/$log_name 
/home/build_config.sh
