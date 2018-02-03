#!/bin/bash
. /home/certs/store/default_cert_details

. /home/engines/functions/params_to_env.sh
params_to_env

if test -z cert_name
 then
  cert_name=$domain_name
fi

required_values="container_type parent_engine domain_name country state city organisation person"
check_required_values

export container_type parent_engine domain_name country state city organisation person wild alt_names hostname install_target

/home/engines/scripts/engine/create_cert.sh