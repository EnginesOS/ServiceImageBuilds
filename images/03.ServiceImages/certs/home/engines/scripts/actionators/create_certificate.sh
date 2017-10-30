#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

#FIXME make engines.internal settable
if test -z "${cert_name}"
 then
  echo Error:Missing cert_name
  exit -1
fi
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