#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env


required_values="cert_name container_type parent_engine domainname country state city organisation person"
check_required_values

export cert_name container_type parent_engine domainname country state city organisation person wild alt_names hostname install_target

/home/engines/scripts/engine/create_cert.sh