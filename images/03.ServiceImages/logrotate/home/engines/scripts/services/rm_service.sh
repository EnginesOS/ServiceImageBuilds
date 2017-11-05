#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="log_file_path parent_engine"
check_required_values

rm /home/saved/$parent_engine/$service_handle.entry

