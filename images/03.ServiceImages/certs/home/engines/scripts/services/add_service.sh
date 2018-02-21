#!/bin/bash
. /home/certs/store/default_cert_details

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="container_type parent_engine common_name country state city organisation person"
check_required_values

export container_type parent_engine common_name country state city organisation person 

/home/engines/scripts/engine/create_cert.sh