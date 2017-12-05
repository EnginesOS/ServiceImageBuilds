#!/bin/bash
. /home/certs/store/default_cert_details

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="cert_name domain_name country state city organisation person"
check_required_values


if test -z $hostname
 then
  wild=yes
  else
   wild=no
fi
parent_engine=system
container_type=service
   
export cert_name container_type parent_engine domain_name country state city organisation person wild alt_names hostname cert_type

/home/engines/scripts/engine/create_cert.sh