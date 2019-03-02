#!/bin/sh
. /home/certs/store/default_cert_details
 . /home/engines/functions/checks.sh
 
 required_values=" common_name country state city organisation person "
check_required_values

export cert_name common_name country state city organisation person cert_type container_type parent_engine

/home/engines/scripts/engine/create_csr.sh
