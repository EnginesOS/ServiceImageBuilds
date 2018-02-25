#!/bin/bash
. /home/certs/store/default_cert_details

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="wild install_target container_type parent_engine common_name country state city organisation person"
check_required_values

export wild container_type install_target parent_engine common_name country state city organisation person 

/home/engines/scripts/engine/create_cert.sh