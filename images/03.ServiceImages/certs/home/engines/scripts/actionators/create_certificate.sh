#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="cert_name domainname country state city organisation person"
check_required_values


if test -z $hostname
 then
  wild=yes
  else
   wild=no
fi
parent_engine=system
container_type=system
   
export cert_name container_type parent_engine domainname country state city organisation person wild alt_names hostname 

/home/engines/scripts/engine/create_cert.sh