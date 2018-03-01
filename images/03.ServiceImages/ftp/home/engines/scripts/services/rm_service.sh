#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env
set > /tmp/full_env

required_values="service_handle"
check_required_values

export service_handle
sudo -n /home/engines/scripts/services/_rm_service.sh

