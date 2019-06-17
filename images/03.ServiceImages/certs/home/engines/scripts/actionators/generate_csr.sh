#!/bin/sh

 . /home/engines/functions/checks.sh
 
 required_values=" common_name country state city organisation person "
check_required_values
ca_name=external_ca
export common_name country state city organisation person cert_type container_type parent_engine ca_name

/home/engines/scripts/engine/create_csr.sh

